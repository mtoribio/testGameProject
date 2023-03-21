class Game
  attr_gtk
  attr_reader :active_controller

  def initialize(args)
    self.args = args
    @active_controller = ::Controllers::TitleController
  end

  def goto_title

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
