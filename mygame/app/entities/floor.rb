module Entities
  class Floor < StaticEntity
    def initialize(opts = {})
      super(opts)
      @path = 'app/sprites/floor.png'
    end
  end
end
