require_relative './test_helper'
require_relative '../lib/point'

class PointTest < Minitest::Test

  test '#w is 1.0' do
    point = Point.new(1, -2, 3)

    assert_instance_of Point, point
    assert_equal 1.0, point.w
  end

end
