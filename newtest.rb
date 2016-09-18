require 'gosu'

class Player
    def initialize
        @image = Gosu::Image.new("Resources/Archer/Archer_Front.png")
        @x, @y = 0
    end

    def testcollide
        @x += 4 if @x <= -17
        @x -= 4 if @x >= 600
        @y += 4 if @y <= -15
        @y -= 4 if @y >= 400
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def left

        @x -= 4
    end
    def right
        @x += 4
    end
    def up
        @y -= 4
    end
    def down
        @y += 4
    end

    def draw
        @image.draw(@x, @y, 1)
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
            @player.left
        end
        if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
            @player.right
        end
        if Gosu::button_down? Gosu::KbUp then
            @player.up
        end
        if Gosu::button_down? Gosu::KbDown then
            @player.down
        end
    end

    def draw
        @player.draw
        @background_image.draw(0, 0, 0);
        @player.testcollide
    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

window = GameWindow.new
window.show
