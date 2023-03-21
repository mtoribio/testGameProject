# frozen_string_literal: true

def tick(args)
  args.outputs.labels << [200, 60, args.state.tick_count, -5, -1, 2000, 33990, 100, 225]
end
