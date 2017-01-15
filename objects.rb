module Objects
    def draw
        @pic.draw(@x, @y, 1)
    end
end

class Stone_Wall
    def initialize
        @pic = Gosu::Image.new("Resources/Objects/Stone_Wall.png")
        @x = 200
        @y = 260
        @stat = true
        @hp = 20
    end
    def dead
        if @hp <= 0
            @stat = false
            return true
        else 
            @stat = true
            return false
        end
    end
    def draw
        @place.draw(@x, @y, 1)
    end
end
