# frozen_string_literal: true

def tick(args)
  args.outputs.labels << [80, 60, args.state.tick_count, -5, -1, 200, 50, 100, 225]
end
