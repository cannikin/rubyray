require_relative './tuple'
require_relative './point_vector_math'

class Point < Tuple
  include PointVectorMath

  W = 1.0

  def initialize(*args)
    super
    @list << W
  end

end
