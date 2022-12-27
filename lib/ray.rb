require_relative './intersection'
require_relative './intersection_collection'

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
    translated = transform(sphere.transform.inverse)

    sphere_to_ray = translated.origin - sphere.origin
    a = translated.direction.dot(translated.direction)
    b = 2 * translated.direction.dot(sphere_to_ray)
    c = sphere_to_ray.dot(sphere_to_ray) -1
    discriminant = b**2 - 4 * a * c

    return IntersectionCollection.new if discriminant < 0

    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    i1 = Intersection.new(t1, sphere)
    i2 = Intersection.new(t2, sphere)

    return IntersectionCollection.new(i1, i2)
  end

  def hit?(sphere)
    intersect(sphere).hit?
  end

  def transform(matrix)
    self.class.new(matrix * origin, matrix * direction)
  end

end
