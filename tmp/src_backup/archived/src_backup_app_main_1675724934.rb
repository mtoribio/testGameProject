# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Start at menu state
  args.state.game_state ||= :menu

  # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    menu_state(args)
  else
    # Otherwise, go to the game state
    game_state(args)
  end

  # debug
  # args.outputs.labels << [0, 400, args.state.game_state, 50, 20, 200, 50, 100, 255]
  # if esc is pressed reset game state
  if args.inputs.keyboard.key_down.escape
    args.gtk.reset
  end
end

def start_player(args)
  # args.state.player.x ||= 100
  # args.state.player.y ||= 100
  # args.state.player.w ||= 64
  # args.state.player.h ||= 64
  # args.state.player.direction ||= 1
end
#   args.state.player.x ||= 100
#   args.state.player.y ||= 100
#   args.state.player.w ||= 64
#   args.state.player.h ||= 64
#   args.state.player.direction ||= 1

#   args.state.player.is_moving = false
#   {
#     x: args.state.player.x,
#     y: args.state.player.y,
#     w: args.state.player.w,
#     h: args.state.player.h,
#     path: 'sprites/horizontal-run.png',
#     tile_x: 0 + (tile_index * args.state.player.w),
#     tile_y: 0,
#     tile_w: args.state.player.w,
#     tile_h: args.state.player.h,
#     flip_horizontally: args.state.player.direction > 0,
#   }
# end

def game_state(args)
  args.state.game_state = :game
  start_player(args)
end

def menu_state(args)
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
  args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' } if (args.state.tick_count % 60).zero?
  # args.outputs.labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 200, font: 'fonts/VT323-Regular.ttf' } if args.state.tick_count.odd?
  # if enter or space is pressed, go to game state
  if args.inputs.keyboard.key_down.enter || args.inputs.keyboard.key_down.space
    args.state.game_state = :game
  end
end

$gtk.reset
