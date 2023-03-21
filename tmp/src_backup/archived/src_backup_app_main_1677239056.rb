# frozen_string_literal: true

require 'app/game.rb'
require 'app/menu.rb'

#

def tick(args)
#   # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  $menu ||= Menu.new(args)
  $game ||= Game.new(args)
    # Otherwise, go to the game state
  $game.tick


end

$gtk.reset


