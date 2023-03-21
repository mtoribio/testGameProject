# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Make a simple game menu with a title and two buttons with hashes
  args.outputs.labels << [400, 400, 'My Game', 50, 20, 200, 50, 100, 255]
  args.outputs.labels << [400, 300, 'Start Game', 50, 20, 200, 50, 100, 255]
  

end
