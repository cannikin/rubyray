require_relative './shape'

class Sphere < Shape

  def intersect(world_ray)
    ray = local_ray(world_ray)

    shape_to_ray = ray.origin - origin
    a = ray.direction.dot(ray.direction)
    b = 2 * ray.direction.dot(shape_to_ray)
    c = shape_to_ray.dot(shape_to_ray) -1
    discriminant = b**2 - 4 * a * c

    return IntersectionCollection.new if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    i1 = Intersection.new(t1, self, world_ray)
    i2 = Intersection.new(t2, self, world_ray)

    return IntersectionCollection.new(i1, i2)
  end

end
