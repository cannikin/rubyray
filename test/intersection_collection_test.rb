require_relative './test_helper'
require_relative '../lib/intersection_collection'
require_relative '../lib/intersection'

class IntersectionCollectionTest < Minitest::Test

  test 'aggregating intersections' do
    sphere = Sphere.new
    int1 = Intersection.new(1, sphere)
    int2 = Intersection.new(2, sphere)
    col = IntersectionCollection.new(int1, int2)

    assert_equal 2, col.size
    assert_equal int1, col[0]
    assert_equal int2, col[1]
  end

  test 'intersections are sorted by increating t' do
    sphere = Sphere.new
    int1 = Intersection.new(4, sphere)
    int2 = Intersection.new(-2, sphere)
    int3 = Intersection.new(3, sphere)
    col = IntersectionCollection.new(int1, int2, int3)

    assert_equal 3, col.size
    assert_equal int2, col[0]
    assert_equal int3, col[1]
    assert_equal int1, col[2]
  end

  test 'the hit, when all intersections have positive t' do
    sphere = Sphere.new
    i1 = Intersection.new(1, sphere)
    i2 = Intersection.new(2, sphere)
    col = IntersectionCollection.new(i2, i1)

    assert_equal i1, col.hit
  end

  test 'the hit, when some intersections have negative t' do
    sphere = Sphere.new
    i1 = Intersection.new(-1, sphere)
    i2 = Intersection.new(1, sphere)
    col = IntersectionCollection.new(i2, i1)

    assert_equal i2, col.hit
  end

  test 'the hit, when all intersections have negative t' do
    sphere = Sphere.new
    i1 = Intersection.new(-2, sphere)
    i2 = Intersection.new(-1, sphere)
    col = IntersectionCollection.new(i2, i1)

    assert_nil col.hit
  end

  test 'the hit is always the lowest non-negative intersection' do
    sphere = Sphere.new
    i1 = Intersection.new(5, sphere)
    i2 = Intersection.new(7, sphere)
    i3 = Intersection.new(-3, sphere)
    i4 = Intersection.new(2, sphere)
    col = IntersectionCollection.new(i1, i2, i3, i4)

    assert_equal i4, col.hit
  end

  test 'hit? convenience function' do
    sphere = Sphere.new
    i1 = Intersection.new(1, sphere)
    i2 = Intersection.new(2, sphere)
    col = IntersectionCollection.new(i2, i1)
    assert col.hit?

    sphere = Sphere.new
    i1 = Intersection.new(-2, sphere)
    i2 = Intersection.new(-1, sphere)
    col = IntersectionCollection.new(i2, i1)
    assert !col.hit?
  end

end
