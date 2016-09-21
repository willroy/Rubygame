require 'gosu'

class Player
    def initialize
        @image = Gosu::Image.new("Resources/Archer/Archer_Front.png")
        @down = Gosu::Image.new("Resources/Archer/Archer_Front.png")
        @up = Gosu::Image.new("Resources/Archer/Archer_Back.png")
        @left = Gosu::Image.new("Resources/Archer/Archer_Left.png")
        @right = Gosu::Image.new("Resources/Archer/Archer_Right.png")
        @direction = @down
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
        @direction = @left
        @x -= 4
    end
    def right
        @direction = @right
        @x += 4
    end
    def up
        @direction = @up
        @y -= 4
    end
    def down
        @direction = @down
        @y += 4
    end

    def draw
        @direction.draw(@x, @y, 1)
    end
end
class MenuWindow < Gosu::Window
    def initialize
        super 639, 398
        self.caption = "Menu"
        
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")
        @cursor = Gosu::Image.new(self, 'Resources/cursor.png')
    end

    def draw
        @Menu_background.draw(0, 0, 0);
        @cursor.draw(self.mouse_x, self.mouse_y, 0)
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end

class GameWindow < Gosu::Window
    def initialize 
        super 640, 480
        self.caption = "Game"
    
        @background_image = Gosu::Image.new("Resources/GameBack.png")

        @player = Player.new
        @player.warp(320, 240)
    end
    def update
        @player.left if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft
        @player.right if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight
        @player.down if Gosu::button_down? Gosu::KbUp
        @player.up if Gosu::button_down? Gosu::KbDown
    end

    def draw
        @player.draw
        @background_image.draw(0, 0, 0);
        @player.testcollide
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end

window = MenuWindow.new
window.show
