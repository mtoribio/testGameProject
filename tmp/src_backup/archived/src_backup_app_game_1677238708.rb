class Game
  attr_gtk
  attr_reader :

  def initialize(args)
    self.args = args
  end

  def tick
    sprites = []
    labels = []

    render(sprites, labels)
  end

  def render(sprites, labels)
    outputs.sprites << sprites
    outputs.labels << labels
  end
end
