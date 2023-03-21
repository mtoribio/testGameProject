# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Start at menu state
  args.state.game_state ||= :menu

  # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    MenuState.new.run(args)
  end

  # debug
  args.outputs.labels << [0, 400, args.state.game_state, 50, 20, 200, 50, 100, 255]
end

# Make a class for the game state
class GameState
  def initialize
    @tick_count = 0
  end

  def run(args)
    @tick_count += 1
    args.outputs.labels << [400, 400, @tick_count, 50, 20, 200, 50, 100, 255]
  end
end

# Make a class for menu state
class MenuState
  def initialize
    # Make title button in hash
    @title = { x: 400, y: 400, text: 'My Game', size_enum: 50, alignment_enum: 0, r: 200, g: 50, b: 100, a: 255 }
    # Make start game button in hash
    @start_game = { x: 400, y: 300, text: 'Start Game', size_enum: 50, alignment_enum: 0, r: 200, g: 50, b: 100, a: 255 }
    @start_game_box = { x: 400, y: 300, w: 200, h: 100, r: 0, g: 0, b: 0, a: 255}
    # Make quit game button in hash
    @quit_game = { x: 400, y: 200, text: 'Quit Game', size_enum: 50, alignment_enum: 0, r: 200, g: 50, b: 100, a: 255 }
  end

  def run(args)
    # Make a simple game menu with a title and two buttons with hashes
    args.outputs.labels << @title
    args.outputs.labels << @start_game
    args.outputs.labels << @quit_game
  end
end

$gtk.reset
