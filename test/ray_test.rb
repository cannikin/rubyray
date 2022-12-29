require_relative './test_helper'

class RayTest < Minitest::Test

  test 'creating and querying a ray' do
    origin = Point.new(1, 2, 3)
    direction = Vector.new(4, 5, 6)
    ray = Ray.new(origin, direction)

    assert_equal origin, ray.origin
    assert_equal direction, ray.direction
  end

  test 'computing a point from a distance' do
    ray = Ray.new(Point.new(2, 3, 4), Vector.new(1, 0, 0))

    assert_equal Point.new(2, 3, 4), ray.position(0)
    assert_equal Point.new(3, 3, 4), ray.position(1)
    assert_equal Point.new(1, 3, 4), ray.position(-1)
    assert_equal Point.new(4.5, 3, 4), ray.position(2.5)
  end

  test 'a ray intersects a sphere at two points' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    intersections = ray.intersect(sphere)

    assert_equal 2, intersections.size
    assert_equal 4.0, intersections[0].t
    assert_equal 6.0, intersections[1].t
  end

  test 'a ray intersects a sphere at a tangent' do
    ray = Ray.new(Point.new(0, 1, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    intersections = ray.intersect(sphere)

    assert_equal 2, intersections.size
    assert_equal 5.0, intersections[0].t
    assert_equal 5.0, intersections[1].t
  end

  test 'a ray misses a sphere' do
    ray = Ray.new(Point.new(0, 2, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    intersections = ray.intersect(sphere)

    assert_equal 0, intersections.size
  end

  test 'a ray originates inside a sphere' do
    ray = Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1))
    sphere = Sphere.new
    intersections = ray.intersect(sphere)

    assert_equal 2, intersections.size
    assert_equal -1.0, intersections[0].t
    assert_equal 1.0, intersections[1].t
  end

  test 'a sphere is behind a ray' do
    ray = Ray.new(Point.new(0, 0, 5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    intersections = ray.intersect(sphere)

    assert_equal 2, intersections.size
    assert_equal -6.0, intersections[0].t
    assert_equal -4.0, intersections[1].t
  end

  test 'intersect sets the object on the intersection' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    intersections = ray.intersect(sphere)

    assert_instance_of IntersectionCollection, intersections
    assert_equal 2, intersections.size

    assert_instance_of Intersection, intersections[0]
    assert_equal sphere, intersections[0].object
    assert_instance_of Intersection, intersections[1]
    assert_equal sphere, intersections[1].object
  end

  test 'translating a ray' do
    ray = Ray.new(Point.new(1, 2, 3), Vector.new(0, 1, 0))
    matrix = Matrix.translate(3, 4, 5)
    ray2 = ray.transform(matrix)

    assert_equal Point.new(4, 6, 8), ray2.origin
    assert_equal Vector.new(0, 1, 0), ray2.direction
  end

  test 'scaling a ray' do
    ray = Ray.new(Point.new(1, 2, 3), Vector.new(0, 1, 0))
    matrix = Matrix.scale(2, 3, 4)
    ray2 = ray.transform(matrix)

    assert_equal Point.new(2, 6, 12), ray2.origin
    assert_equal Vector.new(0, 3, 0), ray2.direction
  end

  test 'intersecting a scaled sphere with a ray' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.scale(2, 2, 2)
    intersections = ray.intersect(sphere)

    assert_equal 2, intersections.size
    assert_equal 3, intersections[0].t
    assert_equal 7, intersections[1].t
  end

  test 'intersecting a translated sphere with a ray' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.translate(5, 0, 0)
    intersections = ray.intersect(sphere)

    assert_equal 0, intersections.size
  end

  test 'hit? convenience function' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.scale(2, 2, 2)
    assert ray.hit?(sphere)

    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.translate(5, 0, 0)
    assert !ray.hit?(sphere)
  end

end
