# Represents a point in 3D space

class Tuple < Struct.new(:x, :y, :z, :w)

  POINT_W = 1.0
  VECTOR_W = 0.0

  def initialize(*args)
    super(*args.collect(&:to_f))
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
    Tuple.new(*self.map { |t| t * num.to_f })
  end

  def -@
    Tuple.new(0, 0, 0, 0.0) - self
  end

  def point?
    w == POINT_W
  end

  def vector?
    w == VECTOR_W
  end

end
