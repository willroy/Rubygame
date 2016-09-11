require 'gosu' 

class Player
    def initialize
        @image = Gosu::Image.new("Resources/Char.png")
        @x = @y = @vel_x = @vel_y = @angle = 0.0
        @score = 0
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def turn_left
        @angle -= 4.5
    end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
class GameWindow < Gosu::Window
    def initialize 
        super 640, 480
        self.caption = "Game"
    
        @background_image = Gosu::Image.new("Resources/BackOne.png")

        @player = Player.new
        @player.warp(320, 240)
    end

    def update
        if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
            @player.turn_left
        end
        if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
            @player.turn_right
        end
        if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
            @player.accelerate
        end
        @player.move
    end

    def draw
        @player.draw
        @background_image.draw(0, 0, 0);
    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

window = GameWindow.new
window.show
