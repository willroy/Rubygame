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
    end
    def update
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if Gosu::button_down? Gosu::KbX
        if self.mouse_x > 472 and self.mouse_x < (472 + @button1.width)
            if self.mouse_y > 22 and self.mouse_y < (22 + @button1.height)
                if Gosu::button_down? Gosu::MsLeft
                    @button1state = true
                else
                    @button1state = false
                end
            else
                @button1state = false
            end
        else
            @button1state = false
        end
    end
    def draw
        @Menu_background.draw(0, 0, 0);
        @button1.draw(472, 22, 1) if @button1state == false
        @button1active.draw(472, 22, 1) if @button1state == true
        @cursor.draw(self.mouse_x, self.mouse_y, 2)
    end

    def button_down(id)
        case id
            when Gosu::KbEscape
                close
        end
    end
    
end

class GameWindow < Gosu::Window
    def initialize(player_type)
        super 640, 480
        self.caption = "Game"
        # put a player if thing that picks a different player subclass for each type of character.
        @background_image = Gosu::Image.new("Resources/BackOne.png")
        # @player_type = player_type
        @player = Player.new # Mage.new
        @player.warp(320, 240)
        # @player = Mage.new if @player_type == "Mage"
        # @player = Archer.new if @player_type == "Archer"
        # @player = Warrior.new if @player_type == "Warrior"
        # @player = Assassin.new if @player_type == "Assassin"
    end
    def update
        @player.left if Gosu::button_down? Gosu::KbLeft
        @player.right if Gosu::button_down? Gosu::KbRight
        @player.up if Gosu::button_down? Gosu::KbUp
        @player.down if Gosu::button_down? Gosu::KbDown
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
