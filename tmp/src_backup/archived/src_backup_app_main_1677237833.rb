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
end
