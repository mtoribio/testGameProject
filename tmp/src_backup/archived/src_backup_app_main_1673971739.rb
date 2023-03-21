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
  render_debug args
end
