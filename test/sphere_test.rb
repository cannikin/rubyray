require_relative 'test_helper'

class ShapeTest < Minitest::Test

  test 'sphere is a shape' do
    assert_kind_of Shape, Sphere.new
  end

  test 'computing the normal on a translated sphere' do
    sphere = Sphere.new
    sphere.transform = Matrix.translate(0, 1, 0)

    assert_equal Vector.new(0, 0.70711, -0.70711), sphere.normal_at(Point.new(0, 1.70711, -0.70711))
  end

  test 'computing the normal on a transformed sphere' do
    sphere = Sphere.new
    sphere.transform = Matrix.scale(1, 0.5, 1) * Matrix.rotate_z(Math::PI / 5)

    assert_equal Vector.new(0, 0.97014, -0.24254), sphere.normal_at(Point.new(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2))
  end

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
