# Represents a point in 3D space

class Tuple < Struct.new(:x, :y, :z)

  def to_a
    [x, y, z]
  end

end
