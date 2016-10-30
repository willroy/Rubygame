#!/usr/bin/ruby
require 'gosu'
require_relative 'player'

class MenuWindow < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Menu"
        
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")
        @cursor = Gosu::Image.new(self, 'Resources/cursor.png')
        @button1 = Gosu::Image.new(self, 'Resources/button1.png')
        @button2 = Gosu::Image.new(self, 'Resources/button2.png')
        @button1active = Gosu::Image.new(self, 'Resources/button1a.png')
        @button2active = Gosu::Image.new(self, 'Resources/button2a.png')
        @active1 = false
        @active2 = false
        $player_type = []
        $close = []

        #class << self
        #    attr_accessor :player_type
        #    attr_accessor :close
        #end

    end

    def draw
        @Menu_background.draw(0, 0, 0);
        @button1.draw(15, 15, 1) if buttonstate(@button1, 15, 15) == false
        @button2.draw(15, 85, 1) if buttonstate(@button2, 15, 85) == false
        if buttonstate(@button1, 15, 15)
            @button1active.draw(15, 15, 1)
            @active1 = true
        end
        if buttonstate(@button2, 15, 85)
            @button2active.draw(15, 85, 1)
            @active2 = true
        end
        
        if @active1 == true and Gosu::button_down? Gosu::MsLeft
            $player_type = "Archer"
            $close = true
            close
        elsif @active2 == true and Gosu:: button_down? Gosu::MsLeft
            $player_type = "Mage"
            $close = true
            close
        else

        end

        @cursor.draw(self.mouse_x, self.mouse_y, 2) 
    end
    def update
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if Gosu::button_down? Gosu::KbX
    end
    def buttonstate(button, coordsx, coordsy)
        if self.mouse_x > coordsx and self.mouse_x < (coordsx + button.width)
            if self.mouse_y > coordsy and self.mouse_y < (coordsy + button.height)
                true
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

        puts "#{@player_type}\n"
        @player_type = player_type
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
playertypes = ["Archer", "Mage", "Warrior", "Assassin"]

while true
    puts "Menu/Game(M/G): "
    which = gets.chomp
    while true
        if which == "M" 
            startg = menu.show 
            if $close == true
                print $player_type
                game = GameWindow.new($player_type)
                game.show
            end
        elsif which == "G"
            count = 0
            while true
                player = gets.chomp()
                count = 0
                game = GameWindow.new(player)
                playertypes.each do |x|
                    if player == x
                        game.show
                    elsif count == 4
                        print "Choose Player Type: "
                    else
                        count += 1
                    end
                end
            end
        elsif which == "GM"
            print $player_type
            game = GameWindow.new($player_type)
            game.show
        else
            break
        end
        break
    end
    break
end
print("\n\n")
