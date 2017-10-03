#!/usr/bin/ruby
require 'gosu'
require_relative 'player'
require_relative 'objects'
require_relative 'npc'
require 'yaml'
#Requiring to player and object files (see files for more info)

#Main menu class for character selection
class MenuWindow < Gosu::Window
    #Subclass of Gosu::Window graphics
    attr_accessor :last_button_pressed 
    attr_accessor :closee
    #Used to see what the user wants to do next
    def initialize
        super 640, 480
        self.caption = "Menu"
        #Title of window
        @Menu_background = Gosu::Image.new("Resources/MenuBack.png")

        @buttons = [
            Button.new(self, "ArcherButton", "Archer", 15, 15, "Game"),
            Button.new(self, "MageButton", "Mage", 15, 85, "Game"),
        ]

        #variables which become true if specific button is pressed
        @closee = "Close"
        #global player_type and close to make sure menu closes and player type is accessible
    end
    def needs_cursor?
        true
        #makes the window show cursor over the top
    end

    def draw
        @Menu_background.draw(0, 0, 0);
        @buttons.each {|b| b.draw}
        #iterate through button list to draw all of them
        @buttons.each do |b|
            if b.clicked?
                #if one is clicked then set that as the last button presesed and close
                @last_button_pressed = b
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

class GameState
    attr_accessor :window, :objects
    def initialize(window, objects)
        @window = window
        @objects = objects
    end
end

class GameWindow < Gosu::Window
    def initialize(player_type)
        super 640, 480
        self.caption = "Game"
        @objects = []
        @game_state = GameState.new(self, @objects)

        @background_image = Gosu::Image.new("Resources/BackOne.png")
        @xshot = @xshot
        @yshot = @yshot
        @player_type = player_type
        @player = Mage.new(@game_state) if @player_type == "Mage"
        @player = Archer.new(@game_state) if @player_type == "Archer"
        @npc = Zombie.new(@game_state, @player)
        walls = YAML.load_file("Resources/walls.yaml")
        walls.each do |wall| 
            @objects << Wall.new(@game_state, wall)
        end
        @count = 0
        @shoot = false
        @objects << @player
        @objects << @npc
    end
    
    def needs_cursor?
        true
        #makes the window show cursor over the top
    end

    def update
        @objects.each{|obj| obj.update}
    end
    
    def draw
        @background_image.draw(0, 0, 0)
        @objects.each{|obj| obj.draw}
    end

    def button_down(id)
        abort if id == Gosu::KbEscape
    end
end

while true
    puts "Launching MenuWindow()"
    menu = MenuWindow.new 
    menu.show()
    button_pressed, closee = menu.last_button_pressed, menu.closee
    
    if closee == "Close"
        break
    elsif button_pressed == nil
        next
    elsif button_pressed.name == "EditorButton"
        editor = EditorWindow.new(button_pressed.character)
        editor.show()
    elsif button_pressed
        game = GameWindow.new(button_pressed.character)
        game.show()
    end
end 
