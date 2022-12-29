class Intersection

  attr_reader :t, :object, :ray

  def initialize(t, object, ray = nil)
    @t = t
    @object = object
    @ray = ray
  end

  def prepare_computations
    point = ray.position(t)
    eyev = -ray.direction
    normalv = object.normal_at(point)
    inside = false

    if normalv.dot(eyev) < 0
      inside = true
      normalv = -normalv
    end

    return { t:, object:, inside:, point:, eyev:, normalv: }
  end
end
