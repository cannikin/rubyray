require_relative './color'
require_relative './intersection_collection'
require_relative './lighting'

class World

  attr_reader :objects, :lights

  def initialize(opts = {})
    @objects = []
    @lights = []
  end

  def reset_lights
    @lights = []
  end

  def add_light(light)
    @lights << light
  end

  def add_lights(*lights)
    lights.each { |light| add_light(light) }
  end

  def add_object(object)
    @objects << object
  end

  def add_objects(*objects)
    objects.each { |object| add_object(object) }
  end

  def intersect(ray)
    intersects = IntersectionCollection.new
    objects.each do |object|
      intersects += object.intersect(ray)
    end
    return intersects
  end

  def shade_hit(comps)
    color = Color.black
    comps => { object:, point:, eyev:, normalv:, over_point: }
    in_shadow = shadowed?(over_point)

    lights.each do |light|
      color += Lighting.light(material: object.material,
                              light:,
                              point:,
                              eyev:,
                              normalv:,
                              in_shadow:)
    end

    return color
  end

  def color_at(ray)
    color = Color.black
    intersections = intersect(ray)

    if intersections.hit?
      color = shade_hit(intersections.hit.prepare_computations)
    end

    return color
  end

  def shadowed?(point)
    shadow_vector = lights.first.position - point
    distance = shadow_vector.magnitude
    direction = shadow_vector.normalize
    ray = Ray.new(point, direction)
    intersections = intersect(ray)
    hit = intersections.hit

    return hit && hit.t < distance
  end

end
