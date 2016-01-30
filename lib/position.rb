def Position(*args)
  case args
  when Array    then Position.new(*args.flatten)
  when Position then args.first
  end
end

class Position
  COMPASS_POINTS = %w[N E S W]
  attr_reader :x, :y, :orientation

  def initialize(x, y, orientation)
    @x, @y = x.to_i, y.to_i
    @orientation = orientation.upcase

    fail ArgumentError, 'Invalid orientation' unless COMPASS_POINTS.include?(@orientation)
    freeze
  end

  def to_ary
    [x, y, orientation]
  end
  alias_method :to_a, :to_ary

  def coords
    [x, y]
  end

  def ==(other)
    other.x == x &&
      other.y == y &&
      other.orientation == orientation
  end

  def rotate_left
    case orientation
    when 'N' then self.class.new(x, y, 'W')
    when 'S' then self.class.new(x, y, 'E')
    when 'W' then self.class.new(x, y, 'S')
    when 'E' then self.class.new(x, y, 'N')
    end
  end

  def rotate_right
    case orientation
    when 'N' then self.class.new(x, y, 'E')
    when 'S' then self.class.new(x, y, 'W')
    when 'W' then self.class.new(x, y, 'N')
    when 'E' then self.class.new(x, y, 'S')
    end
  end

  def move_forward
    case orientation
    when 'N' then self.class.new(x,   y+1, orientation)
    when 'S' then self.class.new(x,   y-1, orientation)
    when 'W' then self.class.new(x-1, y,   orientation)
    when 'E' then self.class.new(x+1, y,   orientation)
    end
  end
end
