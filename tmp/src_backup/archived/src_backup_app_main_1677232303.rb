# frozen_string_literal: true

def tick(args)
#   # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA

  $game ||= Game.new(args)
  $menu ||= Menu.new(args)


  args.state.game_state ||= :menu
#   # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    $menu.tick
  else
    # Otherwise, go to the game state
    $game.tick
  end

  # if esc is pressed reset game state
  if args.inputs.keyboard.key_down.escape
    args.state.game_state = :menu
  end
end
$gtk.reset

class Menu
  attr_gtk

  def initialize(args)
    self.args = args
  end

  def tick
    state.game_state = :menu
    # add background black
    outputs.solids << [0, 0, 1280, 720, 0, 0, 0]

    # add background image
    outputs.sprites << [0, 0, 1280, 720, 'sprites/menu/kid.png']

    # add music to menu
    # outputs.sounds << 'sounds/menu-music2.mp3'

    # load font
    outputs.labels << { x: 150, y: 600, text: 'I want to believe', size_enum: 60, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' }

    # outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' }
    # make a label smooth blink
    outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' } if (state.tick_count % 10).zero?
    # outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 200, font: 'fonts/VT323-Regular.ttf' } if state.tick_count.odd?
    # if enter or space is pressed, go to game state
    if inputs.keyboard.key_down.enter || inputs.keyboard.key_down.space
      state.game_state = :game
    end
  end
end

class Game
  attr_gtk

  def initialize(args)
    self.args = args
    defaults
  end

  def tick
    defaults if player.dy.nil?
    render
    input
    calc

    # add player.action to debug
    outputs.labels << [0, 720, "player.action: #{player.action}", 0, 0, 255]
  end

  def defaults
    player.x                     = 48
    player.y                     = 800
    player.size                  = 48
    player.dx                    = 0
    player.dy                    = 0
    player.action                = :falling

    player.max_speed             = 20
    player.jump_power            = 15
    player.jump_air_time         = 15
    player.jump_increase_power   = 1

    ## Animation
    player.animation_start_at  ||= state.tick_count

    state.gravity                = -1
    state.drag                   = 0.001
    state.tile_size              = 48
    state.tiles                ||= [
      { ordinal_x:  0, ordinal_y: 0 },
      { ordinal_x:  1, ordinal_y: 0 },
      { ordinal_x:  2, ordinal_y: 0 },
      { ordinal_x:  3, ordinal_y: 0 },
      { ordinal_x:  4, ordinal_y: 0 },
      { ordinal_x:  5, ordinal_y: 0 },
      { ordinal_x:  6, ordinal_y: 0 },
      { ordinal_x:  7, ordinal_y: 0 },
      { ordinal_x:  8, ordinal_y: 0 },
      { ordinal_x:  9, ordinal_y: 0 },
      { ordinal_x: 10, ordinal_y: 0 },
      { ordinal_x: 11, ordinal_y: 0 },
      { ordinal_x: 12, ordinal_y: 0 },

      { ordinal_x:  9, ordinal_y: 3 },
      { ordinal_x: 10, ordinal_y: 3 },
      { ordinal_x: 11, ordinal_y: 3 },
    ]

    tiles.each do |t|
      t.rect = { x: t.ordinal_x * 48,
                 y: t.ordinal_y * 48,
                 w: 48,
                 h: 48 }
    end
  end

  def render
    # render background blank
    outputs.solids << [0, 0, 1280, 720, 0, 0, 0]

    render_player
    render_tiles
    # render_grid
  end

  def input
    input_jump
    input_move
  end

  def calc
    calc_player_rect
    calc_left
    calc_right
    calc_below
    calc_above
    calc_player_dy
    calc_player_dx
    calc_game_over
  end

  def render_player
    if player.action == :standing
      render_circle_animation('sprites/player/idle.png', 10)
    elsif player.action == :running
      render_circle_animation('sprites/player/run.png', 8)
    elsif player.action == :jumping
      render_jump_animation(0)
    elsif player.action == :falling
      render_jump_animation(2)
    end
  end

  def render_jump_animation(tile_index)
    outputs.sprites << {
      x: player.x,
      y: player.y,
      w: player.size,
      h: player.size,
      path: 'sprites/player/jump.png',
      tile_x: tile_index * player.size,
      tile_y: 0,
      tile_w: player.size,
      tile_h: player.size,
      flip_horizontally: player.dx.negative?
    }
  end

  def render_circle_animation(path, how_many_frames_in_sprite_sheet)
    how_many_ticks_to_hold_each_frame = 5
    should_the_index_repeat = true

    tile_index = player.animation_start_at.frame_index(
      how_many_frames_in_sprite_sheet,
      how_many_ticks_to_hold_each_frame,
      should_the_index_repeat
    )

    outputs.sprites << {
      x: player.x,
      y: player.y,
      w: player.size,
      h: player.size,
      path: path,
      tile_x: 0 + tile_index * player.size,
      tile_y: 0,
      tile_w: player.size,
      tile_h: player.size,
      flip_horizontally: player.dx.negative?
    }
  end

  def render_tiles
    outputs.sprites << state.tiles.map do |t|
      t.merge path: 'sprites/square/white.png',
              x: t.ordinal_x * 48,
              y: t.ordinal_y * 48,
              w: 48,
              h: 48
    end
  end

  def render_grid
    if state.tick_count == 0
      outputs[:grid].background_color = [0, 0, 0, 0]
      outputs[:grid].borders << available_brick_locations
      outputs[:grid].labels  << available_brick_locations.map do |b|
        [
          b.merge(text: "#{b.ordinal_x},#{b.ordinal_y}",
                  x: b.x + 2,
                  y: b.y + 2,
                  size_enum: -3,
                  vertical_alignment_enum: 0,
                  blendmode_enum: 0),
          b.merge(text: "#{b.x},#{b.y}",
                  x: b.x + 2,
                  y: b.y + 2 + 20,
                  size_enum: -3,
                  vertical_alignment_enum: 0,
                  blendmode_enum: 0)
        ]
      end
    end

    outputs.sprites << { x: 0, y: 0, w: 1280, h: 720, path: :grid }
  end

  def input_jump
    if inputs.keyboard.key_down.space
      player_jump
    end

    if inputs.keyboard.key_held.space
      player_jump_increase_air_time
    end
  end

  def input_move
    if player.dx.abs < 20
      if inputs.keyboard.left
        player.dx -= 2
      elsif inputs.keyboard.right
        player.dx += 2
      end
    end
  end

  def calc_game_over
    if player.y < -48
      player.x = 48
      player.y = 800
      player.dx = 0
      player.dy = 0
    end
  end

  def calc_player_rect
    player.rect      = player_current_rect
    player.next_rect = player_next_rect
    player.prev_rect = player_prev_rect
  end

  def calc_player_dx
    player.dx  = player_next_dx
    player.x  += player.dx
  end

  def calc_player_dy
    player.y  += player.dy
    player.dy  = player_next_dy
  end

  def calc_below
    return unless player.dy < 0
    tiles_below = tiles_find { |t| t.rect.top <= player.prev_rect.y }
    collision = tiles_find_colliding tiles_below, (player.rect.merge y: player.next_rect.y)
    if collision
      player.y  = collision.rect.y + state.tile_size
      player.dy = 0
      player.action = :standing
    else
      player.action = :falling
    end
  end

  def calc_left
    return unless player.dx < 0 && player_next_dx < 0\


  def calc_above
    return unless player.dy > 0
    tiles_above = tiles_find { |t| t.rect.y >= player.prev_rect.y }
    collision = tiles_find_colliding tiles_above, (player.rect.merge y: player.next_rect.y)
    return unless collision
    player.dy = 0
    player.y  = collision.rect.bottom - player.rect.h
  end

  def player_current_rect
    { x: player.x, y: player.y, w: player.size, h: player.size }
  end

  def available_brick_locations
    (0..19).to_a
      .product(0..11)
      .map do |(ordinal_x, ordinal_y)|
      { ordinal_x: ordinal_x,
        ordinal_y: ordinal_y,
        x: ordinal_x * 48,
        y: ordinal_y * 48,
        w: 48,
        h: 48 }
    end
  end

  def player
    state.player ||= args.state.new_entity :player
  end

  def player_next_dy
    player.dy + state.gravity + state.drag ** 2 * -1
  end

  def player_next_dx
    player.dx * 0.8
  end

  def player_next_rect
    player.rect.merge x: player.x + player_next_dx,
                      y: player.y + player_next_dy
  end

  def player_prev_rect
    player.rect.merge x: player.x - player.dx,
                      y: player.y - player.dy
  end

  def player_jump
    return if player.action != :standing
    player.action = :jumping
    player.dy = state.player.jump_power
    current_frame = state.tick_count
    player.action_at = current_frame
  end

  def player_jump_increase_air_time
    return if player.action != :jumping
    return if player.action_at.elapsed_time >= player.jump_air_time
    player.dy += player.jump_increase_power
  end

  def tiles
    state.tiles
  end

  def tiles_find_colliding tiles, target
    tiles.find { |t| t.rect.intersect_rect? target }
  end

  def tiles_find &block
    tiles.find_all(&block)
  end
end
end
