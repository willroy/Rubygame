#!/ur/bin/ruby
require 'gosu'
require 'yaml'

class Objects
    def warp(x, y)
        @x, @y = x, y
    end
    def draw
        @image.draw(@x.to_s.to_i, @y.to_s.to_i, 1)
    end
    def setpos(x=@x, y=@y)
        if !active?()
            @xy = [x, y]
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
    def collision(object=@image, coordsx=@x, coordsy=@y, coords2x, coords2y)
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

    def update
    end
end

class Wall < Objects
    def initialize(game_state)
        @image = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @x = 200
        @y = 260
        @dirm = nil
        @dir = nil
        @cool = 0
        @game_state = game_state
        @health = 100
    end

    def attacked
        @health -= 10
        if @health <= 0
            @game_state.objects.delete(self)
            puts "The wall is dead"
        else
            puts "Hit. Health now: #{@health}"
        end
    end
end 

class Arrow < Objects
    def initialize(game_state, direction, x, y)
        case direction
        when :right
            @image = Gosu::Image.new("Resources/Projectiles/ShotArcher.png")
            @xmod = 10
            @ymod = 0
        when :left
            @image = Gosu::Image.new("Resources/Projectiles/Shotleft.png")
            @xmod = -10
            @ymod = 0
        when :up
            @image = Gosu::Image.new("Resources/Projectiles/Shotup.png")
            @xmod = 0
            @ymod = -10
        else
            @image = Gosu::Image.new("Resources/Projectiles/Shotdown.png")
            @xmod = 0
            @ymod = 10
        end

        @x = x
        @y = y
        @game_state = game_state
        @count = 0
    end

    def attacked
    end

    def update
        @game_state.objects.each { |obj| 
            if obj != self && obj.collision(@x, @y) == true
                @game_state.objects.delete self
                obj.attacked
            end
        }
    end

    def draw
        if @count == 20
            @game_state.objects.delete self
        end

        @x = @x + @xmod
        @y = @y + @ymod
        @image.draw(@x, @y, 2)
        @count += 1
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
