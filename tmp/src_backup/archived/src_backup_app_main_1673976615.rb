# frozen_string_literal: true

def tick(args)
  # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  # args.outputs.labels << [400, 400, args.state.tick_count, 50, 20, 200, 50, 100, 255]

  # Start at menu state
  args.state.game_state ||= :menu

  # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    MenuState.new.run(args)
  end

  #debug
  args.outputs.labels << [0, 400, args.state.game_state, 50, 20, 200, 50, 100, 255]
end


# Make a class for the game state
class GameState
  def initialize
    @tick_count = 0
  end

  def run(args)
    @tick_count += 1
    args.outputs.labels << [400, 400, @tick_count, 50, 20, 200, 50, 100, 255]
  end
end

# Make a class for menu state
class MenuState
  def initialize
    # Make title button in hash

  end

  def run(args)
    # Make a simple game menu with a title and two buttons with hashes
    args.outputs.labels << [400, 400, 'My Game', 50, 20, 200, 50, 100, 255]
    args.outputs.labels << [400, 300, 'Start Game', 50, 20, 200, 50, 100, 255]
    args.outputs.labels << [400, 200, 'Quit Game', 50, 20, 200, 50, 100, 255]

    # Put a background on the menu
    args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0, 255]

    # When the mouse is clicked, check if the mouse is over the start game button
    if args.inputs.mouse.click
      # draw a rectangle around the start game button
      args.outputs.borders << [400, 300, 200, 100, 255, 255, 255, 255]
      if args.inputs.mouse.point.inside_rect?([400, 300, 200, 100])
        # If the mouse is over the start game button, go to the game state
        args.state.game_state = :game
      end
    end

    # If the game state is game, go to the game state
    if args.state.game_state == :game
      GameState.new.run(args)
    end
  end

end

$gtk.reset