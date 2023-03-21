# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Make a menu simple menu for dragonRuby

  args.outputs.labels << {
    x: 400,
    y: 400,
    text: 'Play',
    size: 200,
    alingment: 50,
    red: 20,
    green: 200,
    blue: 50,
    alpha: 255
  }
end