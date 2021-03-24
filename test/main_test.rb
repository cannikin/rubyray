require_relative './test_helper'
require_relative '../main'

class MainTest < Minitest::Test

  test 'creating a point' do
    point = point(4.3, -4.2, 3.1)

    assert_instance_of Tuple, point
    assert point.point?
    refute point.vector?
    assert_equal point.x, 4.3
    assert_equal point.y, -4.2
    assert_equal point.z, 3.1
    assert_equal point.w, 1.0
  end

  test 'creating a vector' do
    vector = vector(4.3, -4.2, 3.1)

    assert_instance_of Tuple, vector
    refute vector.point?
    assert vector.vector?
    assert_equal vector.x, 4.3
    assert_equal vector.y, -4.2
    assert_equal vector.z, 3.1
    assert_equal vector.w, 0.0
  end

end
