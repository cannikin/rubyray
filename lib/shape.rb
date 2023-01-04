require_relative './point'
require_relative './matrix'
require_relative './material'
require_relative './intersection'
require_relative './intersection_collection'

class Shape

  @@id = 0

  attr_reader :id, :origin
  attr_accessor :material, :transform

  def initialize
    @@id += 1
    @id = @@id
    @origin = Point.new(0, 0, 0)
    @transform = Matrix.identity
    @material = Material.new
  end

  def normal_at(world_point)
    object_point = transform.inverse * world_point
    object_normal = object_point - Point.new(0, 0, 0)
    world_normal = transform.inverse.transpose * object_normal

    # avoid having to use a submatrix, just hack the normal back into a vector
    world_normal.to_vector.normalize
  end

  # used by all #intersect() to make sure we're in object space
  def local_ray(ray)
    ray.transform(transform.inverse)
  end

  def hit(ray)
    intersect(ray).hit
  end

  def hit?(ray)
    intersect(ray).hit?
  end

end
