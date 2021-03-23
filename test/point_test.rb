require 'minitest/autorun'
require_relative '../point'

class PointTest < Minitest::Test

  def test_point_initialization
    point = Point.new(4.3, -4.2, 3.1)

    assert_equal point.class, Point
    assert_equal point.x, 4.3
    assert_equal point.y, -4.2
    assert_equal point.z, 3.1
    assert_equal point.w, 1.0
  end

  def test_point_to_array
    point = Point.new(4.3, -4.2, 3.1)

    assert_equal point.to_a, [4.3, -4.2, 3.1, 1.0]
  end

end
