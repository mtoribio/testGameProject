# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Start at menu state
  args.state.game_state ||= :menu

  # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    menu(args)
  else
    # Otherwise, go to the game state
    game(args)
  end

  # if esc is pressed reset game state
  if args.inputs.keyboard.key_down.escape
    args.state.game_state = :menu
  end
end

def game(args)
  playerRun(args)
end

def menu(args)
  args.state.game_state = :menu
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
  args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' } if (args.state.tick_count % 10).zero?
  # args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 200, font: 'fonts/VT323-Regular.ttf' } if args.state.tick_count.odd?
  # if enter or space is pressed, go to game state
  if args.inputs.keyboard.key_down.enter || args.inputs.keyboard.key_down.space
    args.state.game_state = :game
  end
end


def playerRun(args)
  # temporary background
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
  ## draw horizontal line
  args.outputs.solids << [0, 50, 1280, 5, 255, 255, 255]
  args.state.game_state = :game

  args.state.player ||= {
    x: 100,
    y: 50,
    w: 64,
    h: 64,
    direction: 1,
    speed: 5,
    is_moving: false,
    is_jumping: false
  }

  ## player inputs
  if args.inputs.right
    args.state.player.x += 2
    args.state.player.direction = 1
  elsif args.inputs.left
    args.state.player.x -= 2
    args.state.player.direction = -1
  end

  ## add player gravity
  args.state.player.y -= 1 if args.state.player.y > 50

  if !args.state.player.is_jumping
    if args.inputs.up
      args.state.player.y += 5
      args.state.player.is_jumping = true
    elsif args.inputs.down
      args.state.player.y -= 5
    end
  end



  # if args.inputs.up
  #   args.state.player.y += 5
  # elsif args.inputs.down
  #   args.state.player.y -= 5
  # end

  tile_index ||= 0

  args.outputs.sprites << {
    x: args.state.player.x,
    y: args.state.player.y,
    w: args.state.player.w,
    h: args.state.player.h,
    path: 'sprites/player/idle.png',
    tile_x: 0,
    tile_y: 0,
    tile_w: args.state.player.w,
    tile_h: args.state.player.h,
    flip_horizontally: args.state.player.direction.negative?
  }
  tile_index += 1
end
