# Represents a vector in 3D space
require_relative './tuple'

class Vector < Tuple

  def w
    0.0
  end

  def to_a
    super << w
  end

end
