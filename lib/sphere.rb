require_relative './shape'

class Sphere < Shape

  def normal_at(world_point)
    object_point = transform.inverse * world_point
    object_normal = object_point - Point.new(0, 0, 0)
    world_normal = transform.inverse.transpose * object_normal

    # avoid having to use a submatrix, just hack the normal back into a vector
    world_normal.to_vector.normalize
  end

end
