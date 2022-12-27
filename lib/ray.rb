require_relative './intersection'

class Ray

  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def position(time)
    origin + direction * time
  end

  def intersect(sphere)
    sphere_to_ray = origin - sphere.origin
    a = direction.dot(direction)
    b = 2 * direction.dot(sphere_to_ray)
    c = sphere_to_ray.dot(sphere_to_ray) -1
    discriminant = b**2 - 4 * a * c

    return [] if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    i1 = Intersection.new(t1, sphere)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    i2 = Intersection.new(t2, sphere)

    return IntersectionCollection.new(i1, i2)
  end

end
