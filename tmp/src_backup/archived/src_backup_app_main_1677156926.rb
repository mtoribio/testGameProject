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
    $game ||= Game.new
    $game.args = args
    $game.tick
  end

  # if esc is pressed reset game state
  if args.inputs.keyboard.key_down.escape
    args.state.game_state = :menu
  end
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

class Game
  attr_gtk

  def tick
  end
end

$gtk.reset
