require 'gosu'
require_relative 'player'

class MenuWindow < Gosu::Window
    def initialize
        super 639, 398
        self.caption = "Menu"
        
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")
        @cursor = Gosu::Image.new(self, 'Resources/cursor.png')
        @button1 = Gosu::Image.new(self, 'Resources/button1.png')
        @button1active = Gosu::Image.new(self, 'Resources/button1a.png')
    end
    def update
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if Gosu::button_down? Gosu::KbX
    end
    def draw
        @Menu_background.draw(0, 0, 0);
        @button1.draw(472, 5, 1) if buttonstate(@button1, 472, 5) == false
        if buttonstate(@button1, 472, 5) == true
            @button1active.draw(472, 5, 1)
            return "Archer"
            close
        end
        @cursor.draw(self.mouse_x, self.mouse_y, 2) 
    end
    def buttonstate(button, coordsx, coordsy)
        if self.mouse_x > coordsx and self.mouse_x < (coordsx + button.width)
            if self.mouse_y > coordsy and self.mouse_y < (coordsy + button.height)
                if Gosu::button_down? Gosu::MsLeft
                    true
                else
                    false
                end
            else
                false
            end
        else
            false
        end
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
        @background_image = Gosu::Image.new("Resources/BackOne.png")

        @player_type = player_type
        @player = Mage.new if @player_type == "Mage"
        @player = Archer.new if @player_type == "Archer"
        @player = Warrior.new if @player_type == "Warrior"
        @player = Assassin.new if @player_type == "Assassin"


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
player = window.show
game = GameWindow.new(player)
game.show
