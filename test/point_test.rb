require_relative 'test_helper'

class PointTest < Minitest::Test

  test '.origin returns an point at 0, 0, 0' do
    assert_equal Point.new(0, 0, 0), Point.origin
  end

  test '#w is 1.0' do
    point = Point.new(1, -2, 3)

    assert_instance_of Point, point
    assert_equal 1.0, point.w
  end

end
