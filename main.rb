require 'gosu'
require_relative 'player'

class MenuWindow < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Menu"
        
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")
        @cursor = Gosu::Image.new(self, 'Resources/cursor.png')
        @button1 = Gosu::Image.new(self, 'Resources/button1.png')
        @button1active = Gosu::Image.new(self, 'Resources/button1a.png')
        @active = false
    end
    def update
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if Gosu::button_down? Gosu::KbX
    end
    def draw
        @Menu_background.draw(0, 0, 0);
        @button1.draw(15, 15, 1) if buttonstate(@button1, 15, 15) == false
        @button1active.draw(15, 15, 1) if buttonstate(@button1, 15, 15) == true
        close if @active == true and Gosu::button_down? Gosu::MsLeft
        @cursor.draw(self.mouse_x, self.mouse_y, 2) 
    end
    def buttonstate(button, coordsx, coordsy)
        if self.mouse_x > coordsx and self.mouse_x < (coordsx + button.width)
            if self.mouse_y > coordsy and self.mouse_y < (coordsy + button.height)
                true
                @active = true
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
    def initialize #(player_type)
        super 640, 480
        self.caption = "Game"
        @background_image = Gosu::Image.new("Resources/BackOne.png")

        @player_type = "Mage"
        puts "#{@player_type}\n"
        @player = Mage.new if @player_type == "Mage"
        @player = Archer.new if @player_type == "Archer"
        @player = Warrior.new if @player_type == "Warrior"
        @player = Assassin.new if @player_type == "Assassin"
        @coolrange = 0
        @coolmelee = 0
    end
    def update
        @player.left if Gosu::button_down? Gosu::KbA
        @player.right if Gosu::button_down? Gosu::KbD
        @player.up if Gosu::button_down? Gosu::KbW
        @player.down if Gosu::button_down? Gosu::KbS
        if @player_type == "Archer" or @player_type == "Mage"
            if Gosu::button_down? Gosu::KbK 
                if @coolrange <= 0
                    @player.shoot(@cool) 
                    @coolrange = 100
                end
            end
            @coolrange -= 1 if @coolrange > 0
        end

    end

    def draw
        @player.draw
        @background_image.draw(0, 0, 0);
        @player.testcollide()
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end


menu = MenuWindow.new
game = GameWindow.new
playertypes = ["Archer", "Mage", "Warrior", "Assassin"]
while true
    puts "Menu/Game(M/G): "
    which = gets.chomp
    if which == "M" 
        startg = menu.show
        break
    elsif which =="G"
        #player = gets.chomp()
        #playertypes.each |x| do
            #game.show(player) unless player != x
            #if player != x
                #count += 1
                #if count == 4
                    #print "Please Choose a real player type..."   
                #end
            #end
        game.show
        break
    else
        
    end
end
puts startg
if which == "M"
    game.show
end
print "\n\n"
