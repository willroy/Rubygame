#!/ur/bin/ruby
require 'gosu'
require 'yaml'

class Objects
    def warp(x, y)
        @x, @y = x, y
    end
    def draw
        @main_image.draw(@x.to_s.to_i, @y.to_s.to_i, 1)
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

class Wall < Objects
    def initialize(window)
        @main_image = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @x = 200
        @y = 260
        @dirm = nil
        @dir = nil
        @cool = 0
        @window = window
        @health = 100
    end
    def dead
        @health <= 0
    end
    def attacked
        @health -= 10
        puts "Hit. Health now: #{@health}"
    end

    def draw
        if ! dead()
            super
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
