#!/ur/bin/ruby
require 'gosu'
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

class Archer
    include Player
    def initialize
        @shotArcherR = Gosu::Image.new("Resources/Archer/Archer_Rightshoot.png")
        @shotArcherL = Gosu::Image.new("Resources/Archer/Archer_Leftshoot.png")
        @shotArcherD = Gosu::Image.new("Resources/Archer/Archer_Frontshoot.png")
        @shotright = Gosu::Image.new("Resources/Projectiles/ShotArcher.png")
        @shotleft = Gosu::Image.new("Resources/Projectiles/Shotleft.png")
        @shotup = Gosu::Image.new("Resources/Projectiles/Shotup.png")
        @shotdown = Gosu::Image.new("Resources/Projectiles/Shotdown.png")
        @down = Gosu::Image.new("Resources/Archer/Archer_Front.png")
        @up = Gosu::Image.new("Resources/Archer/Archer_Back.png")
        @left = Gosu::Image.new("Resources/Archer/Archer_Left.png")
        @right = Gosu::Image.new("Resources/Archer/Archer_Right.png")
        @x = 320
        @y = 240.0
        @direction = @down
        @dirm = nil
        @dir = nil
        @cool = 0
    end
    def shot
        if @direction == @left
            @direction = @shotArcherL
            @dir = "left"
        elsif @direction == @right
            @direction = @shotArcherR
            @dir = "right"
        elsif @direction == @up
            @dir = "up"
        elsif @direction == @down
            @direction = @shotArcherD
            @dir = "down" 
        end
    end
    def shoot()
        return @dir, @x, @y, @shotright, @shotleft, @shotup, @shotdown
    end
end 

class Mage
    include Player
    def initialize
        @shotMageR = Gosu::Image.new("Resources/Mage/Mage_Rightshoot.png")
        @shotMageL = Gosu::Image.new("Resources/Mage/Mage_Left.png")
        @shotMageD = Gosu::Image.new("Resources/Mage/Mage_Front.png")
        @shotright = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
        @shotleft = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
        @shotup = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
        @shotdown = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
        @down = Gosu::Image.new("Resources/Mage/Mage_Front.png")
        @up = Gosu::Image.new("Resources/Mage/Mage_Back.png")
        @left = Gosu::Image.new("Resources/Mage/Mage_Left.png")
        @right = Gosu::Image.new("Resources/Mage/Mage_Right.png")
        @x = 320
        @y = 240.0
        @direction = @down
        @cool = 0
    end
    def shot
        if @direction == @left
            @direction = @shotMageL
            @dir = "left"
        elsif @direction == @right
            @direction = @shotMageR
            @dir = "right"
        elsif @direction == @up
            @dir = "up"
        elsif @direction == @down
            @direction = @shotMageD
            @dir = "down"
            
        end
    end
    def shoot()
        return @dir, @x, @y, @shotright, @shotleft, @shotup, @shotdown
    end
end 

class Warrior
    include Player, Melee
    def initialize
        @down = Gosu::Image.new("Resources/Warrior/Warrior_Front.png")
        @up = Gosu::Image.new("Resources/Warrior/Warrior_Back.png")
        @left = Gosu::Image.new("Resources/Warrior/Warrior_Left.png")
        @right = Gosu::Image.new("Resources/Warrior/Warrior_Right.png")
        @x = 320
        @y = 240.0
        @direction = @down
        @cool = 0
    end
    def melee()
        #return somthing (i'll work it out)
    end
end  
class Assassin
    include Player, Melee
    def initialize
        @down = Gosu::Image.new("Resources/Assassin/Assassin_Front.png")
        @up = Gosu::Image.new("Resources/Assassin/Assassin_Back.png")
        @left = Gosu::Image.new("Resources/Assassin/Assassin_Left.png")
        @right = Gosu::Image.new("Resources/Assassin/Assassin_Right.png")
        @x = 320
        @y = 240.0
        @direction = @down
        @cool = 0
    end
    def melee()
        #return somthing (i'll work it out)
    end
end  
