# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Make a simple game menu with a title and two buttons with hashes
  args.outputs.labels << [400, 400, 'My Game', 50, 20, 200, 50, 100, 255]
  args.outputs.labels << [400, 300, 'Start Game', 50, 20, 200, 50, 100, 255]
  args.outputs.labels << [400, 200, 'Quit Game', 50, 20, 200, 50, 100, 255]

  # Put a background on the menu
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 255]

  # 

end


# Make a class for the game state
class GameState

end