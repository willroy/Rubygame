#!/ur/bin/ruby
require 'gosu'
require 'yaml'

class Objects
    def warp(x, y)
        @x, @y = x, y
    end


    def width
        @image.width
    end

    def height
        @image.height
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

    def inside(x, left, right)
        left <= x && x <= right
    end

    def collision(other)
        self_in_x = inside(@x, other.x, other.x + other.width)
        self_in_y = inside(@y, other.y, other.y + other.height) 
        other_in_x = inside(other.x, @x, @x + width) 
        other_in_y = inside(other.y, @y, @y + height)

        (self_in_x || other_in_x) && (self_in_y || other_in_y)
    end

    def update
    end
end

class Wall < Objects
    attr_reader :x, :y
    def initialize(game_state, wall)
        @image = Gosu::Image.new(game_state.window, "Resources/Objects/Stone_Wall.png", false,  wall["x"], wall["y"], wall["w"], wall["h"], :tileable => true)
        @x = wall["x"]
        @y = wall["y"]
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

class PlsmaBall < Objects
    attr_reader :x, :y
    def initialize(game_state, belongs_to, direction, x, y)
        case direction
        when :right
            @image = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
            @xmod = 10
            @ymod = 0
        when :left
            @image = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
            @xmod = -10
            @ymod = 0
        when :up
            @image = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
            @xmod = 0
            @ymod = -10
        else
            @image = Gosu::Image.new("Resources/Projectiles/ShotMage.png")
            @xmod = 0
            @ymod = 10
        end

        @x = x
        @y = y - 20
        @game_state = game_state
        @belongs_to = belongs_to
        @count = 0
    end
    def attacked
    end
    def update
        @game_state.objects.each { |obj| 
            if obj != self && obj != @belongs_to && collision(obj)
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
class Arrow < Objects
    attr_reader :x, :y
    def initialize(game_state, belongs_to, direction, x, y)
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
        @belongs_to = belongs_to
        @count = 0
    end

    def attacked
    end

    def update
        @game_state.objects.each do |obj| 
            if obj != self && obj != @belongs_to && collision(obj)
                @game_state.objects.delete self
                obj.attacked
            end
        end
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
        abort if id == Gosu::KbEscape
    end
    def active?
        if @window.mouse_x > @x and @window.mouse_x < (@x + @main_image.width)
            if @window.mouse_y > @y and @window.mouse_y < (@y + @main_image.height)
                return true
            end
        end
        false
    end
    def draw
        if active?
            @active_image.draw(@x, @y, 1)
        else
            @main_image.draw(@x, @y, 1)
        end
    end
end
