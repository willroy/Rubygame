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
        @direction.draw(@x, @y, 1)
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