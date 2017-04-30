#!/usr/bin/ruby
require 'gosu'
require_relative 'player'
require_relative 'objects'
#Requiring to player and object files (see files for more info)
#
#Main menu class for character selection
class MenuWindow < Gosu::Window
    #Subclass of Gosu::Window graphics
    attr_accessor :player_type 
    attr_accessor :closee
    def initialize
        super 640, 480
        self.caption = "Menu"
        #Title of window
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")

        @buttons = [
            Button.new(self, "button1", "Archer", 15, 15, true),
            Button.new(self, "button2", "Mage", 15, 85, true),
            Button.new(self, "button3", "Warrior", 15, 155, true),
            Button.new(self, "button4", "Assassin", 15, 225, true),
            Button.new(self, "button5", nil,  200, 225, nil)
        ]

        #variables which become true if specific button is pressed
        @player_type = nil
        @closee = false
        #global player_type and close to make sure menu closes and player type is accessible
    end
    def player_type
        @player_type
    end
    def closee
        @closee
    end
    def needs_cursor?
        true
        #makes the window show cursor over the top
    end

    def draw
        @Menu_background.draw(0, 0, 0);
        @buttons.each {|b| b.draw}

        @buttons.each do |b|
            if b.clicked?
                @player_type = b.character
                @closee = b.close_state
                close
            end
        end
    end
        
    def update
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if Gosu::button_down? Gosu::KbX
        #testing feature for getting coords
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end

end

class EditorWindow < Gosu::Window
    #need to stop screen going Black
    def initialize(player_type, close)
        super 640, 480
        self.caption = "Editor"
        @background_image = Gosu::Image.new("Resources/BackOne.png")
        @player_type = player_type
        puts "#{@player_type}"

        @object = Wall.new
        @buttonED = Gosu::Image.new(self, "Resources/buttonED.png")
        @buttonEDactive = Gosu::Image.new(self, "Resources/buttonEDa.png")
        @activeED = false
        @close = nil
    end
    def needs_cursor?
        true
        #makes the window show cursor over the top
    end
    def update

    end
    def draw
        @background_image.draw(0, 0, 0)
        @x, @y = self.mouse_x, self.mouse_y if Gosu::button_down? Gosu::MsLeft
        @object.setpos(@x, @y)
        @object.draw
        @buttonED.draw(460, 400, 1) if buttonstate(@buttonED, 460, 400) == false
        if buttonstate(@buttonED, 460, 400)
            @buttonEDactive.draw(460, 400, 1)
            @activeED = true
        end
        if @activeED == true and Gosu::button_down? Gosu::MsLeft
            @close = true
            @object.setpos(@x, @y)
            close
        else
        @activeED = false
        end
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
        #ah yes, the mighty ominous "buttonstate" function. this tests if the mouse is on the button by testing areas
        #between the x and y of the bottom left and the top right coords
        #returns true or false depending on what is going on.
    end

    def button_down(id)
        close if id == Gosu::KbEscape
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
        @object = Wall.new
        @count = 0
        @shoot = false
    end
    def update
        @player.left if Gosu::button_down? Gosu::KbA
        @player.right if Gosu::button_down? Gosu::KbD
        @player.up if Gosu::button_down? Gosu::KbW
        @player.down if Gosu::button_down? Gosu::KbS
        if Gosu::button_down? Gosu::KbK 
            @player.shot if @player_type == "Archer" or @player_type == "Mage"
        end
    end
    def needs_cursor?
        true
        #makes the window show cursor over the top
    end
    def draw
        @object.draw
        @player.draw
        @background_image.draw(0, 0, 0)
        @player.testcollide()
        @object.testcollide()
        if @player_type == "Archer" or @player_type == "Mage"
            if Gosu::button_down? Gosu::KbK 
                @shoot = true
            end
        end
        if @count == 200 or @count == -200
            @shoot = false
        end
        if @shoot == true
            @direction, @xshot, @yshot, @shotright, @shotleft, @shotup, @shotdown = @player.shoot() 

            @shotright.draw((@xshot + @count), @yshot, 2) if @direction == "right"
            @shotleft.draw((@xshot + @count), @yshot, 2) if @direction == "left"
            @shotup.draw(@xshot, (@yshot + @count), 2) if @direction == "up"
            @shotdown.draw(@xshot, (@yshot + @count), 2) if @direction == "down"
            @count += 10 if @direction == "right" or @direction == "down"
            @count -= 10 if @direction == "left" or @direction == "up"
        else
            @count = 0 if @direction != "left"
            @count = -30 if @direction == "left"
        end
        
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end


menu = MenuWindow.new
playertypes = ["Archer", "Mage", "Warrior", "Assassin"]

while true
    puts "Menu/Game/Editor(M/G/E): "
    which = gets.chomp
    while true
        if which == "M" 
            menu.show
            closee = menu.closee
            player_type = menu.player_type
            if closee == true
                game = GameWindow.new(player_type)
                game.show
                break
            elsif closee == nil
                puts "Please type a player type: "
                player = gets.chomp()
                count = 0
                editor = EditorWindow.new(player, closee)
                playertypes.each do |x|
                    if player == x
                        if editor.show
                            puts "hello"
                        end
                        if closee == true
                            menu.show
                            print player_type
                            game = GameWindow.new(player_type)
                            game.show
                            break
                        end
                    elsif count == 4
                        print "Choose Player Type: "
                    else
                        count += 1
                    end
                    break
                end
                break
            end
        elsif which == "G"
            while true
                puts "Please type a player type: "
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
                break
            end
        elsif which == "E"
            while true
                puts "Please type a player type: "
                player = gets.chomp()
                count = 0
                editor = EditorWindow.new(player, closee)
                playertypes.each do |x|
                    if player == x
                        editor.show
                    elsif count == 4
                        print "Choose Player Type: "
                    else
                        count += 1
                    end
                end
                break
            end
        else
            break
        end
        break
    end
    break
end
print("\n\n")
