# Represents a point in 3D space

class Tuple

  POINT_W = 1.0
  VECTOR_W = 0.0

  attr_reader :x, :y, :z, :w

  def initialize(x, y, z, w)
    @x = x.to_f
    @y = y.to_f
    @z = z.to_f
    case w
    when Symbol
      case w
      when :point
        @w = POINT_W
      when :vector
        @w = VECTOR_W
      else
        raise StandardError, "Unknown type"
      end
    else
      @w = w
    end
  end

  def to_a
    [x, y, z, w]
  end
  alias :to_ary :to_a

  def ==(other)
    self.to_a == other.to_a
  end

  def +(other)
    Tuple.new(*[self, other].transpose.map(&:sum))
  end

  def -(other)
    Tuple.new(*[self, other].transpose.map { |arr| arr[0] - arr[1] })
  end

  def *(num)
    Tuple.new(*self.to_a.map { |t| t * num.to_f })
  end

  def /(num)
    self * (1.0 / num)
  end

  # negation
  def -@
    Tuple.new(0, 0, 0, 0.0) - self
  end

  def magnitude
    Math.sqrt(x**2 + y**2 + z**2 + w**2)
  end

  # converts a tuple into a unit vector (magnitude of 1)
  def normalize
    mag = magnitude
    Tuple.new(x / mag, y / mag, z / mag, w / mag)
  end

  def dot(other)
    self.x * other.x +
    self.y * other.y +
    self.z * other.z +
    self.w * other.w
  end

  def cross(other)
    new_x = self.y * other.z - self.z * other.y
    new_y = self.z * other.x - self.x * other.z
    new_z = self.x * other.y - self.y * other.x

    Tuple.new(new_x, new_y, new_z, :vector)
  end

  def point?
    w == POINT_W
  end

  def vector?
    w == VECTOR_W
  end

end
