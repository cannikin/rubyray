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

  # subclasses call super() with a block that defines how to transform a
  # local point to a local normal
  def normal_at(world_point, &block)
    local_point = transform.inverse * world_point
    local_normal = yield(local_point)
    world_normal = transform.inverse.transpose * local_normal
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
