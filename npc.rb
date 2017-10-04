class Npc
  attr_reader :x, :y
  def testcollide
    @x += 4 if @x <= -17
    @x -= 4 if @x >= 600
    @y += 4 if @y <= -15
    @y -= 4 if @y >= 400
  end
  def collision(object=@image, coordsx=@x, coordsy=@y, coords2x, coords2y)
    if coords2x > coordsx and coords2x < (coordsx + @image.width)
      if coords2y > coordsy and coords2y < (coordsy + @image.height)
        true
      else
        false
      end
    else
      false
    end
  end
  def attacked
    @health -= 10
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
    @x -= 1.5
  end
  def right
    @direction = :right
    @image = @images[:right]
    @x += 1.5
  end
  def up
    @direction = :up
    @image = @images[:up]
    @y -= 1.5
  end
  def down
    @direction = :down
    @image = @images[:down]
    @y += 1.5
  end
  def draw 
    @image.draw(@x, @y, 1) 
  end
  def go_to(object_target)  
    if object_target.y < @y + 10
      up()
    end
    if object_target.y > @y + 10
      down()
    end
    if object_target.x < @x + 10
      left()
    end
    if object_target.x > @x + 10
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
    @health = 100
    @attackdelay = 0
  end
  def update
    @game_state.objects.delete(self) if @health <= 0
    @attackdelay += 1
    go_to(@player)
    if collision(@player.x, @player.y)  
      @player.attacked()
    end   
  end
  def draw
    super
    self.testcollide()
  end
end 
