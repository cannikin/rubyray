require_relative './test_helper'
require_relative '../point'

class PointTest < Minitest::Test

  test '#w is 1.0' do
    point = Point.new(1, -2, 3)

    assert_equal point.w, 1.0
  end

end
