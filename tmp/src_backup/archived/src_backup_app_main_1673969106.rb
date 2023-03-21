# frozen_string_literal: true

def tick(args)
  args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]
end
