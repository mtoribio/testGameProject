# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Make a simple menu for dragonruby using hash
  args.outputs.labels << {
    x: 400,
    y: 400,
    text: args.state.tick_count,
    size_enum: 50,
    alignment_enum: 20,
    r: 200,
    g: 50,
    b: 100,
    a: 255
  }

end
