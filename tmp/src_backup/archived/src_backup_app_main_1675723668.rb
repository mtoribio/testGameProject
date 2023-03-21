# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Start at menu state
  args.state.game_state ||= :menu
  args.state.menu ||= MenuState.new
  args.state.game ||= GameState.new

  # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    args.state.menu.run(args)
  else
    # Otherwise, go to the game state
    args.state.game.run(args)
  end

  # debug
  # args.outputs.labels << [0, 400, args.state.game_state, 50, 20, 200, 50, 100, 255]
  # if esc is pressed reset game state
  if args.inputs.keyboard.key_down.escape
    args.gtk.reset
  end
end

def player(args)
  # Player
  args.state.player ||= {
    x: 0,
    y: 0,
    w: 64,
    h: 64,
    speed: 10,
    color: [255, 255, 255]
  }

  # Player movement
  args.state.player.x += args.state.player.speed if args.inputs.keyboard.key_down.right
  args.state.player.x -= args.state.player.speed if args.inputs.keyboard.key_down.left
  args.state.player.y += args.state.player.speed if args.inputs.keyboard.key_down.up
  args.state.player.y -= args.state.player.speed if args.inputs.keyboard.key_down.down

  # Player collision
  args.state.player.x = 0 if args.state.player.x.negative?
  args.state.player.x = 736 if args.state.player.x > 736
  args.state.player.y = 0 if args.state.player.y.negative?
  args.state.player.y = 736 if args.state.player.y > 736

  # Player render
  # if !args.state.player.started_running_at
  #   tile_index = 0
  # else
  #   how_many_frames_in_sprite_sheet = 10
  #   how_many_ticks_to_hold_each_frame = 1
  #   should_the_index_repeat = true
  #   tile_index = args.state
  #                  .player
  #                  .started_running_at
  #                  .frame_index(how_many_frames_in_sprite_sheet,
  #                               how_many_ticks_to_hold_each_frame,
  #                               should_the_index_repeat)
  # end

  outputs.sprites << {
    x: args.state.player.x,
    y: args.state.player.y,
    w: args.state.player.w,
    h: args.state.player.h,
    path: 'sprites/player/idle.png',
    tile_x: 0 + (tile_index * args.state.player.w),
    tile_y: 0,
    tile_w: args.state.player.w,
    tile_h: args.state.player.h,
    flip_horizontally: args.state.player.direction.positive?
  }
end

# Make a class for the game state
class GameState
  def initialize
    @tick_count = 0
  end

  def run(args)
    @tick_count += 1
    args.outputs.labels << [400, 400, @tick_count, 50, 20, 200, 50, 100, 255]
    player
  end
end

# Make a class for menu state
class MenuState
  def initialize
    # Make title button in hash
    @title = { x: 400, y: 400, text: 'My Game', size_enum: 50, alignment_enum: 0, r: 200, g: 50, b: 100, a: 255 }
    # Make start game button in hash
    @start_game = { x: 400, y: 300, text: 'Start Game', size_enum: 50, alignment_enum: 0, r: 200, g: 50, b: 100, a: 255 }
    @start_game_box = { x: 400, y: 300, w: 200, h: 100, r: 0, g: 0, b: 0, a: 255 }
    # Make quit game button in hash
    @quit_game = { x: 400, y: 200, text: 'Quit Game', size_enum: 50, alignment_enum: 0, r: 200, g: 50, b: 100, a: 255 }
  end

  def run(args)
    # Make a simple game menu with a title and two buttons with hashes
    # args.outputs.labels << @title
    # args.outputs.labels << @start_game
    # args.outputs.labels << @quit_game

    # add background black
    args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]

    # add background image
    args.outputs.sprites << [0, 0, 1280, 720, 'sprites/menu/kid.png']

    # add music to menu
    # args.outputs.sounds << 'sounds/menu-music2.mp3'

    # load font
    args.outputs.labels << { x: 150, y: 600, text: 'I want to believe', size_enum: 60, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' }

    # args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' }
    # make a label smooth blink
    args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' } if args.state.tick_count.even?
    args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 200, font: 'fonts/VT323-Regular.ttf' } if args.state.tick_count.odd?

    # if enter or space is pressed, go to game state
    if args.inputs.keyboard.key_down.enter || args.inputs.keyboard.key_down.space
      args.state.game_state = :game
    end
  end
end

$gtk.reset
