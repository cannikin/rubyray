require_relative "tuple"

class Vector < Tuple
  def initialize(*args)
    super
    @list << 0.0
  end

  def -@
    Vector.new(0, 0, 0) - self
  end

  def magnitude
    Math.sqrt(@list.map { |a| a**2 }.sum)
  end

  # converts a tuple into a unit vector (magnitude of 1)
  def normalize
    mag = magnitude
    Vector.new(x / mag, y / mag, z / mag)
  end

  def dot(other)
    x * other.x +
      y * other.y +
      z * other.z +
      w * other.w
  end

  def cross(other)
    new_x = y * other.z - z * other.y
    new_y = z * other.x - x * other.z
    new_z = x * other.y - y * other.x

    Vector.new(new_x, new_y, new_z)
  end

  def reflect(normal)
    self - normal * 2 * dot(normal)
  end
end
