# Represents a point in 3D space
require_relative './tuple'

class Point < Tuple

  def w
    1.0
  end

  def to_a
    super << w
  end

end
