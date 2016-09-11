require 'gosu'

class GameWindow < Gosu::Window
    def initialize(width=640, height=480, fullscreen=false)
        super
        @x = @y = 20
        @image = Gosu::Image.new("Resources/Char.png")
        @draws = 0
        @buttons_down = 0
    end

    def update
        @x -= 2 if button_down?(Gosu::KbLeft)
        @x += 2 if button_down?(Gosu::KbRight)
        @y -= 2 if button_down?(Gosu::KbUp)
        @y += 2 if button_down?(Gosu::KbDown)
    end

    def button_down(id)
        close if id == Gosu::KbEscape
        @buttons_down += 1
    end

    def buttons_up(id)
        @buttons_down -= 1
    end

    def needs_redraw?
        @draws == 0 || @buttons_down > 0
    end

    def draw
        @message = Gosu::Image.from_text(self, info, Gosu.default_font_name, 30)
        @draws += 1
        @image.draw(@x, @y, 1)
        @message.draw(10, 10, 1)
        testcollide
    end
    
    def testcollide
        if @x <= -20
            @x += 2
        end
        if @x >= 560
            @x -= 2
        end
        if @y <= -60
            @y += 2
        end
        if @y >= 340
            @y -= 2   
        end
    end

    def info
        "[x:#{@x};y:#{@y};draws:#{@draws}]"
    end
end

window = GameWindow.new
window.show
