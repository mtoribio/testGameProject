# frozen_string_literal: true

require 'app/game.rb'
require 'app/menu.rb'

require 'app/controllers/title_controller.rb'
require 'app/controllers/game_controller.rb'

#

def tick(args)
#   # array format: X, Y, TEXT, SIZE, ALINGMENT, R,G,B, ALPHA
  $game ||= Game.new(args)
  $game.tick

  ## DEBUG
  args.outputs.debug << args.gtk.framerate_diagnostics_primitives
end

$gtk.reset


