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
  attr_accessor :character, :protocol
  #Used to see what the user wants to do next
  def initialize
    super 640, 480
    self.caption = "Menu"
    @protocol = "firstmenu"
  end
  def set_window_vals
    @background = Gosu::Image.new("Resources/MenuBack.png")
    if @protocol == "firstmenu"
      @buttons =  [
        Button.new(self, "NewGameButton", "New Game", 15, 15, "charselect") ]
    elsif @protocol == "charselect"
      @buttons = [
        Button.new(self, "ArcherButton", "Archer", 15, 85, "gamestart"),
        Button.new(self, "MageButton", "Mage", 15, 170, "gamestart") ]
    end
  end
  def needs_cursor?
    true
    #makes the window show cursor over the top
  end
  def draw
    @background.draw(0, 0, 0)
    @buttons.each {|b| b.draw}
  end
  def update
    set_window_vals
    #testing feature for getting coords
    @buttons.each do |b|
      if b.clicked?
        @protocol = b.protocol
        puts b.protocol
        @character = b.character
      end
    end
    if @protocol == "gamestart"
      close
    end 
  end
  def button_down(id)
    close if id == Gosu::KbEscape
    puts("X: #{self.mouse_x} Y: #{self.mouse_y}") if id == Gosu::KbX
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
    @game_over_screen = Gosu::Image.new("Resources/Gameover.png")
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
    @objects << @player unless @player == nil
    @objects << @npc unless @npc == nil
  end
  def needs_cursor?
    true
    #makes the window show cursor over the top
  end
  def update
    @objects.each {|obj| obj.update} 
    if Gosu::button_down? Gosu::KbEscape 
     if @player.dead 
       abort
     end
    end
  end
  def draw
    @background_image.draw(0, 0, 0) unless @player.dead == true
    @objects.each{|obj| obj.draw} unless @player.dead == true
    @game_over_screen.draw(0, 0, 0) if @player.dead == true
  end
  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

while true
  puts "Launching MenuWindow"
  menu = MenuWindow.new 
  menu.show()
  protocol = menu.protocol
  begin
    if protocol == "Close"
      puts "Closing"
      break
    elsif protocol == "gamestart"
      puts "Launching GameWindow"
      game = GameWindow.new(menu.character)
      puts "show"
      begin
        game.show()
      rescue Exception => e
        puts e
      end
      puts "showdone?"
    else
      break
    end
  rescue Exception => e
    puts e
    break
  end
end
