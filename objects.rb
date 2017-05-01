#!/ur/bin/ruby
require 'gosu'
module Objects
    def testcollide
        @x += 4 if @x <= -17
        @x -= 4 if @x >= 600
        @y += 4 if @y <= -15
        @y -= 4 if @y >= 400
    end
    def warp(x, y)
        @x, @y = x, y
    end
    def left
        @direction = @left
        @x -= 4
    end
    def right
        @direction = @right
        @x += 4
    end
    def up
        @direction = @up
        @y -= 4
    end
    def down
        @direction = @down
        @y += 4
    end
    def draw
        @direction.draw(@x.to_i, @y.to_i, 1)
    end
    def setpos(x=@x, y=@y)
        @x, @y = x, y
    end
end

class Wall
    include Objects
    def initialize
        @down = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @up = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @left = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @right = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @x = 200
        @y = 260
        @direction = @down
        @dirm = nil
        @dir = nil
        @cool = 0
    end
end 

class Button
    attr_accessor :character, :close_state
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
    
    def clicked?
        active? and Gosu::button_down? Gosu::MsLeft 
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
    def draw
        if active?
            @active_image.draw(@x, @y, 1)
        else
            @main_image.draw(@x, @y, 1)
        end
    end
end
