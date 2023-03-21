class Game
  attr_gtk
  attr_reader :active_controller

  def initialize(args)
    self.args = args
    @active_controller = goto_title
  end

  def goto_title
    @active_controller = ::Controllers::TitleController
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
