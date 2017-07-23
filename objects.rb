#!/ur/bin/ruby
require 'gosu'
require 'yaml'

module Objects
    def warp(x, y)
        @x, @y = x, y
    end
    def draw
        @x, @y, @health = YAML.load_file("Storage/info.yml")
        puts "#{@x}, #{@y}, #{@health}"
        @main_image.draw(@x.to_s.to_i, @y.to_s.to_i, 1)
    end
    def setpos(x=@x, y=@y)
        if !active?()
            @xy = [x, y]
            File.open("Storage/info.yml", "w") {|f| f.write(@xy.to_yaml) }
        end
    end
    def active?
        if @window.mouse_x > @x and @window.mouse_x < (@x + @main_image.width)
            if @window.mouse_y > @y and @window.mouse_y < (@y + @main_image.height)
                return true
            end
        end
        false
    end  
    def collision(object=@main_image, coordsx=@x, coordsy=@y, coords2x, coords2y)
        puts "#{coords2x}, #{coords2y}"
        if coords2x.to_i > coordsx.to_i and coords2x.to_i < (coordsx.to_i + object.width)
            if coords2y.to_i > coordsy.to_i.to_i and coords2y.to_i < (coordsy.to_i + object.height)
                true
            else
                false
            end
        else
            false
        end
    end
end

class Wall
    include Objects
    def initialize(window)
        @main_image = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @x = 200
        @y = 260
        @dead = false
        @dirm = nil
        @dir = nil
        @cool = 0
        @window = window
        @health = 100
        @x, @y, @health = YAML.load_file("Storage/info.yml")
    end
    def dead
        @dead
    end
    def attacked
        config = YAML.load_file("Storage/info.yml")
        puts "#{config}"
        config[2] = config[2] - 10
        File.open("Storage/info.yml", "w") do |out| 
            yaml.dump(config, out)
        end
        if @health <= 0
            @dead = true
        end
    end
end 

class Button
    attr_accessor :character, :close_state, :name
    def initialize(window, name, character, x, y, close_state=true)
        @window = window
        @name = name
        @character = character
        @close_state = close_state
        @x = x
        @y = y
        @main_image = Gosu::Image.new(@window, "Resources/#{name}.png")
        @active_image = Gosu::Image.new(@window, "Resources/#{name}a.png")
    end
    def clicked?
        active? and Gosu::button_down? Gosu::MsLeft 
    end
    def button_down(id)
        close if id == Gosu::KbEscape
    end
    def active?
        if @window.mouse_x > @x and @window.mouse_x < (@x + @main_image.width)
            if @window.mouse_y > @y and @window.mouse_y < (@y + @main_image.height)
                return true
            end
        end
        false
        #ah yes, the mighty ominous "buttonstate" function. this tests if the mouse is on the button by testing areas
        #between the x and y of the bottom left and the top right coords
        #returns true or false depending on what is going on.
    end
    def draw
        if active?
            @active_image.draw(@x, @y, 1)
        else
            @main_image.draw(@x, @y, 1)
        end
    end
end
