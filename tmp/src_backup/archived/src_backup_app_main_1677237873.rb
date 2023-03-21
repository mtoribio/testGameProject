# frozen_string_literal: true

def tick(args)
#   # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA

  $game ||= Game.new(args)
  $menu ||= Menu.new(args)


  args.state.game_state ||= :menu
#   # If the game state is menu, go to the menu state
  if args.state.game_state == :menu
    $menu.tick
  else
    # Otherwise, go to the game state
    $game.tick
  end

  # if esc is pressed reset game state
  if args.inputs.keyboard.key_down.escape
    args.state.game_state = :menu
  end
end
$gtk.reset


