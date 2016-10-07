module Player
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

module Shoot
    def shoot(cool)
        shootq = Random.new
        if shootq.rand(10) >= 4
            print "It Hit!"
            return true
        else
            print "It Missed! :("
            return false
        end
    end
end

module Melee
    def melee(cool)
        meleeq = Random.new
        if melee1.rand(10) >= 4
            print "It hit"
            return true
        else
            print "It Missed! :("
            return false
        end
    end
end

class Archer
    include Player, Shoot
    def initialize
        @down = Gosu::Image.new("Resources/Archer/Archer_Front.png")
        @up = Gosu::Image.new("Resources/Archer/Archer_Back.png")
        @left = Gosu::Image.new("Resources/Archer/Archer_Left.png")
        @right = Gosu::Image.new("Resources/Archer/Archer_Right.png")
        @x = 320
        @y = 240.0
        @direction = @down
        @cool = 0
    end
end 

class Mage
    include Player, Shoot
    def initialize
        @down = Gosu::Image.new("Resources/Mage/Mage_Front.png")
        @up = Gosu::Image.new("Resources/Mage/Mage_Back.png")
        @left = Gosu::Image.new("Resources/Mage/Mage_Left.png")
        @right = Gosu::Image.new("Resources/Mage/Mage_Right.png")
        @x = 320
        @y = 240.0
        @direction = @down
        @cool = 0
    end
end 

