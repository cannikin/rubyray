require_relative './test_helper'
require_relative '../lib/point'
require_relative '../lib/vector'

class PointTest < Minitest::Test

  test '#w is 1.0' do
    point = Point.new(1, -2, 3)

    assert_instance_of Point, point
    assert_equal 1.0, point.w
  end

  # point_vector_math
  test 'adding a point to a vector returns a point' do
    point = Point.new(1, 2, 3)
    vector = Vector.new(2, 3, 4)

    assert_instance_of Point, point + vector
  end

  # point_vector_math
  test 'subtracing a vector from a point returns a point' do
    point = Point.new(1, 2, 3)
    vector = Vector.new(2, 3, 4)

    assert_instance_of Point, point - vector
  end

  # point_vector_math
  test 'subtracing a point from a vector raises an error' do
    point = Point.new(1, 2, 3)
    vector = Vector.new(2, 3, 4)

    assert_raises(Tuple::UnknownTupleError) { vector - point }
  end

  # point_vector_math
  test 'adding two points raises an error' do
    point1 = Point.new(1, 2, 3)
    point2 = Point.new(2, 3, 4)

    assert_raises(Tuple::UnknownTupleError) { point1 + point2 }
  end

end
