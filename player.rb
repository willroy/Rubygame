#!/ur/bin/ruby
class Player
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
  attr_accessor :attacking, :dead, :images, :direction
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
    @health = 100
    @dead = false 
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
      arrow_x = @x
      arrow_y = @y + 50
      @game_state.objects << Arrow.new(@game_state, self,  @direction, arrow_x, arrow_y)
    end
    @dead = true if @health <= 0
  end

  def draw
    super
    self.testcollide
  end
end 

class Mage < Player
  attr_accessor :attacking, :dead
  def initialize(game_state)
    @images = {
      shotMageR: Gosu::Image.new("Resources/Mage/Mage_Rightshoot.png"),
      shotMageL: Gosu::Image.new("Resources/Mage/Mage_Left.png"),
      shotMageD: Gosu::Image.new("Resources/Mage/Mage_Front.png"),
      down: Gosu::Image.new("Resources/Mage/Mage_Front.png"),
      up: Gosu::Image.new("Resources/Mage/Mage_Back.png"),
      left: Gosu::Image.new("Resources/Mage/Mage_Left.png"),
      right: Gosu::Image.new("Resources/Mage/Mage_Right.png"),
    }
    @game_state = game_state
    @x = 320
    @y = 240.0
    @direction = :down
    @image = @images[@direction]
    @attacking = false
    @health = 100
    @dead = false 
  end
  def shot
    if @direction == :left
      @image = @images[:shotMageL]
    elsif @direction == :right
      @image = @images[:shotMageR]
    elsif @direction == :down
      @image = @images[:shotMageD]
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
      plsmaball_x = @x
      plsmaball_y = @y + 50
      @game_state.objects << PlsmaBall.new(@game_state, self,  @direction, plsmaball_x, plsmaball_y)
    end
    @dead = true if @health <= 0
  end

  def draw
    super
    self.testcollide
  end
end 
