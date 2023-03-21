# frozen_string_literal: true

def tick(args)
  args.outputs.labels << [10, 20, args.state.tick_count, 50, 200, 2000, 50, 100, 225]
end
