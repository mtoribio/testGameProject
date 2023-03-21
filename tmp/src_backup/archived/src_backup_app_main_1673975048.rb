# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Make a menu simple menu for dragonRuby

  args.outputs.labels << {
    x: 400,
    y: 600,
    text: 'Play',
    size_enum: 100,
    alingment_enum: 0,
    r: 20,
    g: 200,
    b: 50,
    a: 255
  }
  # write a simple menu for dragonRuby
  # args.outputs.labels << [400, 400, 'Play', 100, 0, 20, 200, 50, 255]
  # args.outputs.labels << [400, 300, 'Settings', 100, 0, 20, 200, 50, 255]
  # args.outputs.labels << [400, 200, 'Exit', 100, 0, 20, 200, 50, 255]
end
