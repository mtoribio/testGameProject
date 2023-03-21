module Entities
  class Wall < StaticEntity
    def initialize(opts = {})
      super(opts)
      @path = 'app/sprites/wall.png'
    end
  end
end
