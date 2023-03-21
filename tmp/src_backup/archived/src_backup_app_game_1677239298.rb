class Game
  attr_gtk
  attr_reader :active_controller

  def initialize(args)
    self.args = args
    goto_title
  end

  def goto_title
    @active_controller = ::Controllers::TitleController
  end

  def goto_game
    @active_controller = ::Controllers::GameController
    

  def tick
    sprites = []
    labels = []

    active_controller.tick(args)
    active_controller.render(state, sprites, labels)

    render(sprites, labels)
  end

  def render(sprites, labels)
    outputs.sprites << sprites
    outputs.labels << labels
  end
end
