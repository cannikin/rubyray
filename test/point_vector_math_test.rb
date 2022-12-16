require_relative './test_helper'
require_relative '../lib/point'
require_relative '../lib/vector'

class PointVectorMathTest < Minitest::Test

  test 'adding two points raises an error' do
    point1 = Point.new(1, 2, 3)
    point2 = Point.new(2, 3, 4)

    assert_raises(Tuple::UnknownTupleError) { point1 + point2 }
  end

  test 'subtracting two points returns a vector' do
    point1 = Point.new(1, 2, 3)
    point2 = Point.new(2, 3, 4)
    result = point1 - point2

    assert_equal Vector.new(-1, -1, -1), result
  end

  test 'adding two vectors is a vector' do
    vector1 = Vector.new(3, 2, 1)
    vector2 = Vector.new(5, 6, 7)
    result = vector1 + vector2

    assert_equal Vector.new(8, 8, 8), result
  end

  test 'subtracing two vectors is a vector' do
    vector1 = Vector.new(3, 2, 1)
    vector2 = Vector.new(5, 6, 7)
    result = vector1 - vector2

    assert_equal Vector.new(-2, -4, -6), result
  end

  test 'adding a point to a vector is a point' do
    point = Point.new(1, 2, 3)
    vector = Vector.new(2, 3, 4)
    result = point + vector

    assert_equal Point.new(3, 5, 7), result
  end

  test 'subtracing a vector from a point is a point' do
    point = Point.new(1, 2, 3)
    vector = Vector.new(2, 3, 4)
    result = point - vector

    assert_equal Point.new(-1, -1, -1), result
  end

  test 'subtracing a point from a vector raises an error' do
    point = Point.new(1, 2, 3)
    vector = Vector.new(2, 3, 4)

    assert_raises(Tuple::UnknownTupleError) { vector - point }
  end

end
