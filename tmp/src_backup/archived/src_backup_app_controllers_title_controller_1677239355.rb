module Controllers
  class TitleController
    def self.tick(args)
      $game.goto_game(args) if args.inputs.keyboard.en
    end

    def self.render(state, sprites, labels)
      sprites << [0, 0, 1280, 720, 'sprites/menu/kid.png']

      labels << { x: 150, y: 600, text: 'I want to believe', size_enum: 60, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' }
      labels << { x: 500, y: 300, text: 'Press start', size_enum: 20, alignment_enum: 0, r: 255, g: 255, b: 255, a: 255, font: 'fonts/VT323-Regular.ttf' }
    end
  end
end
