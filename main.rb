#!/usr/bin/ruby
require 'gosu'
require_relative 'player'
require_relative 'objects'
#Requiring to player and object files (see files for more info)
#
#Main menu class for character selection
class MenuWindow < Gosu::Window
    #Subclass of Gosu::Window graphics
    def initialize
        super 640, 480
        self.caption = "Menu"
        #Title of window
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")
        @button1 = Gosu::Image.new(self, "Resources/button1.png")
        @button2 = Gosu::Image.new(self, "Resources/button2.png")
        @button1active = Gosu::Image.new(self, "Resources/button1a.png")
        @button2active = Gosu::Image.new(self, "Resources/button2a.png")
        @button3 = Gosu::Image.new(self, "Resources/button3.png")
        @button4 = Gosu::Image.new(self, "Resources/button4.png")
        @button3active = Gosu::Image.new(self, "Resources/button3a.png")
        @button4active = Gosu::Image.new(self, "Resources/button4a.png")
        @button5 = Gosu::Image.new(self, "Resources/button5.png")
        @button5active = Gosu::Image.new(self, "Resources/button5a.png")
        #setting multiple variables to button and background pngs
        @active1 = false
        @active2 = false
        @active3 = false
        @active4 = false
        @active5 = false
        #variables which become true if specific button is pressed
        $player_type = nil
        $close = false
        #global player_type and close to make sure menu closes and player type is accessible
    end
    def needs_cursor?
        true
        #makes the window show cursor over the top
    end
    def draw
        @Menu_background.draw(0, 0, 0);
        @button1.draw(15, 15, 1) if buttonstate(@button1, 15, 15) == false
        @button2.draw(15, 85, 1) if buttonstate(@button2, 15, 85) == false
        @button3.draw(15, 155, 1) if buttonstate(@button3, 15, 155) == false
        @button4.draw(15, 225, 1) if buttonstate(@button4, 15, 225) == false
        @button5.draw(200, 225, 1) if buttonstate(@button5, 200, 225) == false

        #Shows not active button state unless the state is true and the mouse is on top of button
        if buttonstate(@button1, 15, 15)
            @button1active.draw(15, 15, 1)
            @active1 = true
        end
        if buttonstate(@button2, 15, 85)
            @button2active.draw(15, 85, 1)
            @active2 = true
        end
        if buttonstate(@button3, 15, 155)
            @button3active.draw(15, 155, 1)
            @active3 = true
        end
        if buttonstate(@button4, 15, 225)
            @button4active.draw(15, 225, 1)
            @active4 = true
        end
        if buttonstate(@button5, 200, 225)
            @button5active.draw(200, 225, 1)
            @active5 = true
        end
        #if it is true than draw the active state buttons
        
        if @active1 == true and Gosu::button_down? Gosu::MsLeft
            $player_type = "Archer"
            $close = true
            close
        elsif @active2 == true and Gosu::button_down? Gosu::MsLeft
            $player_type = "Mage"
            $close = true
            close
        elsif @active3 == true and Gosu::button_down? Gosu::MsLeft
            player_type = "Warrior"
            $close = true
            close
        elsif @active4 == true and Gosu::button_down? Gosu::MsLeft
            $player_type = "Assassin"
            $close = true
            close
        elsif @active5 == true and Gosu::button_down? Gosu::MsLeft
            $close = nil
            close
        else
        #sets the player type and close variables (player type is according to button)

        end
        @active1 = false
        @active2 = false
        @active3 = false
        @active4 = false
        @active5 = false
        #sets the states back and continues loop throughout draw method
    end
    def update
        puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if Gosu::button_down? Gosu::KbX
        #testing feature for getting coords
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
        case id
            when Gosu::KbEscape
                close
        end
        #if pressed escape (esc) it will exit
    end
end
class EditorWindow < Gosu::Window
    #need to stop screen going Black
    def initialize(player_type)
        super 640, 480
        self.caption = "Editor"
        @background_image = Gosu::Image.new("Resources/BackOne.png")
        @player_type = player_type
        puts "#{@player_type}"

        @object = Wall.new
        @buttonED = Gosu::Image.new(self, "Resources/buttonED.png")
        @buttonEDactive = Gosu::Image.new(self, "Resources/buttonEDa.png")
        @activeED = false
        $close = nil
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
            $close = true
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
            if $close == true
                print $player_type
                game = GameWindow.new($player_type)
                game.show
                break
            elsif $close == nil
                puts "Please type a player type: "
                player = gets.chomp()
                count = 0
                editor = EditorWindow.new(player)
                playertypes.each do |x|
                    if player == x
                        editor.show
                        if $close == true
                            menu.show
                            print $player_type
                            game = GameWindow.new($player_type)
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
                editor = EditorWindow.new(player)
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
