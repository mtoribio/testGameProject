# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Start at menu state
  args.state.game_state ||= :menu

  # When the mouse is clicked, check if the mouse is over the start game button
  if args.inputs.mouse.click
    if args.inputs.mouse.point.inside_rect?([400, 300, 200, 100])
      # If the mouse is over the start game button, go to the game state
      args.state.game_state = :game
    end
  end

  # If the game state is game, go to the game state
  if args.state.game_state == :game
    game_state(args)
  end
end


# Make a class for the game state
class GameState
  def initialize
    @tick_count = 0
  end

  def tick(args)
    @tick_count += 1
    args.outputs.labels << [400, 400, @tick_count, 50, 20, 200, 50, 100, 255]
  end
end

# Make a class for menu state
class MenuState
  def initialize
    @tick_count = 0
  end

  def tick(args)
    @tick_count += 1
    args.outputs.labels << [400, 400, @tick_count, 50, 20, 200, 50, 100, 255]
  end
end
