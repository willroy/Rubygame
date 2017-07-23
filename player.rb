#!/ur/bin/ruby
require 'gosu'
class Player
    def testcollide
        @x += 4 if @x <= -17
        @x -= 4 if @x >= 600
        @y += 4 if @y <= -15
        @y -= 4 if @y >= 400
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

    def attacked
    end

    def warp(x, y)
        @x, @y = x, y
    end
    def left
        @direction = :left
        @image = @images[:left]
        @x -= 4
    end
    def right
        @direction = :right
        @image = @images[:right]
        @x += 4
    end
    def up
        @direction = :up
        @image = @images[:up]
        @y -= 4
    end
    def down
        @direction = :down
        @image = @images[:down]
        @y += 4
    end
    def draw 
        @image.draw(@x, @y, 1)
    end
end

class Archer < Player

    attr_accessor :attacking
    def initialize(game_state)
        @images = {
            shotArcherR: Gosu::Image.new("Resources/Archer/Archer_Rightshoot.png"),
            shotArcherL: Gosu::Image.new("Resources/Archer/Archer_Leftshoot.png"),
            shotArcherD: Gosu::Image.new("Resources/Archer/Archer_Frontshoot.png"),
            down: Gosu::Image.new("Resources/Archer/Archer_Front.png"),
            up: Gosu::Image.new("Resources/Archer/Archer_Back.png"),
            left: Gosu::Image.new("Resources/Archer/Archer_Left.png"),
            right: Gosu::Image.new("Resources/Archer/Archer_Right.png")
        }
        @game_state = game_state
        @x = 320
        @y = 240.0
        @direction = :down
        @image = @images[@direction]
        @attacking = false
    end
    def shot
        if @direction == :left
            @image = @images[:shotArcherL]
        elsif @direction == :right
            @image = @images[:shotArcherR]
        elsif @direction == :down
            @image = @images[:shotArcherD]
        end
    end
    def shoot()
        return @dir, @x, @y, @shotright, @shotleft, @shotup, @shotdown
    end

    def update
        self.left if Gosu::button_down? Gosu::KbA
        self.right if Gosu::button_down? Gosu::KbD
        self.up if Gosu::button_down? Gosu::KbW
        self.down if Gosu::button_down? Gosu::KbS

        if Gosu::button_down? Gosu::KbK 
            self.attacking = true
        elsif ! Gosu::button_down? Gosu::KbK and self.attacking
            self.attacking = false
            self.shot
            @game_state.objects << Arrow.new(@game_state, @direction, @x, @y)
        end
    end

    def draw
        super
        self.testcollide
    end
end 

class Mage < Player
    def initialize(game_state)
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
