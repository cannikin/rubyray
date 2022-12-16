require_relative './tuple'
require_relative './point_vector_math'

class Vector < Tuple
  include PointVectorMath

  def initialize(*args)
    super
    @list << 0.0
  end

  def -@
    Vector.new(0, 0, 0) - self
  end

  def magnitude
    Math.sqrt(@list.map { |a| a ** 2 }.sum)
  end

  # converts a tuple into a unit vector (magnitude of 1)
  def normalize
    mag = magnitude
    Vector.new(x / mag, y / mag, z / mag)
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

    Vector.new(new_x, new_y, new_z)
  end

end
