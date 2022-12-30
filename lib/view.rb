require_relative 'matrix'

class View

  def self.transform(from, to, up)
    forward = (to - from).normalize
    left = forward.cross(up.normalize)
    true_up = left.cross(forward)
    orientation = Matrix.new([
      [left.x,     left.y,     left.z,     0],
      [true_up.x,  true_up.y,  true_up.z,  0],
      [-forward.x, -forward.y, -forward.z, 0],
      [0,          0,          0,          1]
    ])

    return orientation * Matrix.translate(-from.x, -from.y, -from.z)
  end

end
