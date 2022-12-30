require_relative 'test_helper'

class IntersectionTest < Minitest::Test

  test 'an intersection encapsulates t, object and ray' do
    sphere = Sphere.new
    ray = Ray.new(Point.new(0, 0, 1), Vector.new(0, 0, 1))
    intersection = Intersection.new(3.5, sphere, ray)

    assert_equal 3.5, intersection.t
    assert_equal sphere, intersection.object
    assert_equal ray, intersection.ray
  end

  test 'precomputing the state of an intersection' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    shape = Sphere.new
    intersection = Intersection.new(4, shape, ray)
    comps = intersection.prepare_computations

    assert_equal intersection.t, comps[:t]
    assert_equal intersection.object, comps[:object]
    assert_equal Point.new(0, 0, -1), comps[:point]
    assert_equal Vector.new(0, 0, -1), comps[:eyev]
    assert_equal Vector.new(0, 0, -1), comps[:normalv]
  end

  test 'the hit, when an intersection occurs on the outside' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    shape = Sphere.new
    intersection = Intersection.new(4, shape, ray)

    assert !intersection.prepare_computations[:inside]
  end

  test 'the hit, when an intersection occurs on the inside' do
    ray = Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1))
    shape = Sphere.new
    intersection = Intersection.new(1, shape, ray)
    comps = intersection.prepare_computations

    assert_equal Point.new(0, 0, 1), comps[:point]
    assert_equal Vector.new(0, 0, -1), comps[:eyev]
    assert comps[:inside]
    assert_equal Vector.new(0, 0, -1), comps[:normalv]
  end

end
