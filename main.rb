require 'gosu'
# Make a load of player subclasses
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

# Add a check if click function, which starts the game window with a certain character chosen
class MenuWindow < Gosu::Window
    def initialize
        super 639, 398
        self.caption = "Menu"
        
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")
        @cursor = Gosu::Image.new(self, 'Resources/cursor.png')
        @button1 = Gosu::Image.new(self, 'Resources/button1.png')
        @button1active = Gosu::Image.new(self, 'Resources/button1active.png')
        @button1state = false
        @requestxy == false
    end
    def update
        @requestxy == true if text_input == "xy"
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if @requestxy == true
    end
    def draw
        @Menu_background.draw(0, 0, 0);
        @button1.draw(482, 22, 1) if @button1state == false
        @button1active.draw(482, 22, 1) if @button1state == true
        @cursor.draw(self.mouse_x, self.mouse_y, 2)
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end

class GameWindow < Gosu::Window
    def initialize 
        super 640, 480
        self.caption = "Game"
        # put a player if thing that picks a different player subclass for each type of character.
        @background_image = Gosu::Image.new("Resources/GameBack.png")
        #if @playertype == mage
        @player = Player.new # Mage.new
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
