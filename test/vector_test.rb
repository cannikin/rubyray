require_relative './test_helper'
require_relative '../lib/tuple'
require_relative '../lib/vector'

class VectorTest < Minitest::Test

  test '#w is 0.0' do
    vector = Vector.new(1, -2, 3)

    assert_equal 0.0, vector.w
  end

  test 'multipling a vector' do
    vector = Vector.new(1, -2, 3)

    assert_equal(Vector.new(2, -4, 6), vector * 2)
  end

  test 'negating a vector' do
    vector = Vector.new(1, -2, 3)

    assert_equal(Vector.new(-1, 2, -3), -vector)
  end

  test '#magnitude' do
    vector = Vector.new(1, 0, 0)
    assert_equal 1.0, vector.magnitude

    vector = Vector.new(0, 1, 0)
    assert_equal 1.0, vector.magnitude

    vector = Vector.new(0, 0, 1)
    assert_equal 1.0, vector.magnitude

    vector = Vector.new(1, 2, 3)
    assert_equal Math.sqrt(14), vector.magnitude

    vector = Vector.new(-1, -2, -3)
    assert_equal Math.sqrt(14), vector.magnitude
  end

  test '#normalize' do
    vector = Vector.new(4, 0, 0).normalize
    assert_equal vector, Vector.new(1, 0, 0)

    vector = Vector.new(1, 2, 3).normalize
    assert_in_epsilon vector.x, 0.26726, Tuple::EPSILON
    assert_in_epsilon vector.y, 0.53452, Tuple::EPSILON
    assert_in_epsilon vector.z, 0.80178, Tuple::EPSILON
  end

  test "normalized tuple's magnitude is always 1.0" do
    vector = Vector.new(1, 2, 3).normalize
    assert_equal 1.0, vector.magnitude

    vector = Vector.new(-1, -2, -3).normalize
    assert_equal 1.0, vector.magnitude
  end

  test '#dot' do
    vector1 = Vector.new(1, 2, 3)
    vector2 = Vector.new(2, 3, 4)
    result = vector1.dot(vector2)

    assert_equal 20, result
  end

  test '#cross' do
    vector1 = Vector.new(1, 2, 3)
    vector2 = Vector.new(2, 3, 4)

    result1 = vector1.cross(vector2)
    assert_equal Vector.new(-1, 2, -1), result1

    result2 = vector2.cross(vector1)
    assert_equal Vector.new(1, -2, 1), result2
  end

end
