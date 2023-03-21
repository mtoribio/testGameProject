module Entities
  class Base
    attr_sprite

    SPRITE_WIDTH = 48
    SPRITE_HEIGHT = 48

    def initialize(opts = {})
      @x = opts[:x] || 0
      @y = opts[:y] || 0
      @w = opts[:w] || SPRITE_WIDTH
      @h = opts[:h] || SPRITE_HEIGHT
      @path = opts[:path] || 'sprites/missing.png'
    end
  end
end
