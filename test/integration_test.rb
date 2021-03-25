require_relative './test_helper'
require_relative '../point'
require_relative '../vector'

class IntegrationTest < Minitest::Test

  test 'adding a point and vector returns a point' do
    point = Point.new(3, -2, 5)
    vector = Vector.new(-2, 3, 1)
    result = point + vector

    assert_instance_of Point, result
    assert_equal result, Point.new(1, 1, 6)
  end

  test 'subtracing two points returns a vector' do
    point1 = Point.new(3, 2, 1)
    point2 = Point.new(5, 6, 7)
    result = point1 - point2

    assert_instance_of Vector, result
    assert_equal result, Vector.new(-2, -4, -6)
  end

  test 'subtracting a vector from a point returns a point' do
    point = Point.new(3, 2, 1)
    vector = Vector.new(5, 6, 7)
    result = point - vector

    assert_instance_of Point, result
    assert_equal result, Point.new(-2, -4, -6)
  end

end

