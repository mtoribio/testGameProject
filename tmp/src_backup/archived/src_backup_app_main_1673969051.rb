# frozen_string_literal: true

def tick(args)
  args.outputs.labels << [0, 00, args.state.tick_count, 50, 200, 2000, 50, 100, 225]
end
