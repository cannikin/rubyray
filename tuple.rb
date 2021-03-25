# Represents a point in 3D space

class Tuple

  def initialize(*args)
    @list = args.map(&:to_f)
  end

  def x
    @list[0]
  end

  def y
    @list[1]
  end

  def z
    @list[2]
  end

  def w
    @list[3]
  end

  def to_a
    @list
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

  def -@
    Tuple.new(*@list.map { |a| 0 }) - self
  end

end
