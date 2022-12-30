class Tuple

  # prevent circular dependencies
  autoload :Point, File.join(File.dirname(__FILE__), 'point.rb')
  autoload :Vector, File.join(File.dirname(__FILE__), 'vector.rb')

  # two floats with a difference less than this should be considered equal
  EPSILON = 0.00001

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
    (x - other.x).abs <= EPSILON and
    (y - other.y).abs <= EPSILON and
    (z - other.z).abs <= EPSILON and
    w == other.w
  end

  def +(other)
    # transpose will first put all the pairs that need to be summed together
    # for easy summing:  [1,2,3], [4,5,6] => [1,4], [2,5], [3,6]
    self.class.new(*[self, other].transpose.map(&:sum)).to_concrete_type
  end

  def -(other)
    self.class.new(*[self, other].transpose.map { |arr| arr[0] - arr[1] }).to_concrete_type
  end

  def *(num)
    self.class.new(*self.to_a.map { |t| t * num.to_f }).to_concrete_type
  end

  def /(num)
    self * (1.0 / num)
  end

  def -@
    Tuple.new(0, 0, 0, 0) - self
  end

  def to_point
    Point.new(x, y, z)
  end

  def to_vector
    Vector.new(x, y, z)
  end

  def point?
    w == 1
  end

  def vector?
    w == 0
  end

  def type
    return :point  if point?
    return :vector if vector?
    return :unknown
  end

  def to_concrete_type
    return to_point if point?
    return to_vector if vector?
    return self
  end

end
