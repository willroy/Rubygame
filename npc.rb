class Npc
    attr_reader :x, :y
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
    def width
        @image.width
    end
    def height
        @image.height
    end
    def left
        @direction = :left
        @image = @images[:left]
        @x -= 2
    end
    def right
        @direction = :right
        @image = @images[:right]
        @x += 2
    end
    def up
        @direction = :up
        @image = @images[:up]
        @y -= 2
    end
    def down
        @direction = :down
        @image = @images[:down]
        @y += 2
    end
    def draw 
        @image.draw(@x, @y, 1)
    end
    def go_to(object_target)  
      if object_target.y < @y
        up()
      elsif object_target.y > @y
        down()
      elsif object_target.x < @x
        left()
      elsif object_target.x > @x
        right()
      end
    end
end

class Zombie < Npc
    attr_accessor :attacking
    def initialize(game_state, player)
        @images = {
            shotZombieR: Gosu::Image.new("Resources/Zombie/Zombie_Right.png"),
            shotZombieL: Gosu::Image.new("Resources/Zombie/Zombie_Left.png"),
            shotZombieD: Gosu::Image.new("Resources/Zombie/Zombie_Front.png"),
            down: Gosu::Image.new("Resources/Zombie/Zombie_Front.png"),
            up: Gosu::Image.new("Resources/Zombie/Zombie_Back.png"),
            left: Gosu::Image.new("Resources/Zombie/Zombie_Left.png"),
            right: Gosu::Image.new("Resources/Zombie/Zombie_Right.png")
        }
        @player = player
        @game_state = game_state
        @x = 200
        @y = 100.0
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
    def attack()
        return @dir, @x, @y, @shotright, @shotleft, @shotup, @shotdown
    end
    def update
        go_to(@player)
    end
    def draw
        super
        self.testcollide
    end
end 
