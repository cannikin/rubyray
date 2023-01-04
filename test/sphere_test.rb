require_relative 'test_helper'

class ShapeTest < Minitest::Test

  test 'intersecting a scaled sphere with a ray' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.scale(2, 2, 2)
    intersections = sphere.intersect(ray)

    assert_equal 2, intersections.size
    assert_equal 3, intersections[0].t
    assert_equal 7, intersections[1].t
  end

  test 'intersecting a translated sphere with a ray' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.translate(5, 0, 0)
    intersections = sphere.intersect(ray)

    assert_equal 0, intersections.size
  end

end
