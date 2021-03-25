require_relative './test_helper'
require_relative '../vector'

class VectorTest < Minitest::Test

  test 'adding two vectors is a vector' do
    vector1 = Vector.new(3, 2, 1)
    vector2 = Vector.new(5, 6, 7)
    result = vector1 + vector2

    assert_instance_of Vector, result
    assert_equal result, Vector.new(8, 8, 8)
  end

  test 'subtracing two vectors is a vector' do
    vector1 = Vector.new(3, 2, 1)
    vector2 = Vector.new(5, 6, 7)
    result = vector1 - vector2

    assert_instance_of Vector, result
    assert_equal result, Vector.new(-2, -4, -6)
  end

  test '#w is 0.0' do
    vector = Vector.new(1, -2, 3)

    assert_equal vector.w, 0.0
  end

  test 'negating a vector' do
    vector = Vector.new(1, -2, 3)

    assert_equal(-vector, Vector.new(-1, 2, -3))
  end

  test '#magnitude' do
    vector = Vector.new(1, 0, 0)
    assert_equal vector.magnitude, 1.0

    vector = Vector.new(0, 1, 0)
    assert_equal vector.magnitude, 1.0

    vector = Vector.new(0, 0, 1)
    assert_equal vector.magnitude, 1.0

    vector = Vector.new(1, 2, 3)
    assert_equal vector.magnitude, Math.sqrt(14)

    vector = Vector.new(-1, -2, -3)
    assert_equal vector.magnitude, Math.sqrt(14)
  end

  test '#normalize' do
    vector = Vector.new(4, 0, 0).normalize
    assert_equal vector, Vector.new(1, 0, 0)

    vector = Vector.new(1, 2, 3).normalize
    assert_in_epsilon vector.x, 0.26726, 0.00001
    assert_in_epsilon vector.y, 0.53452, 0.00001
    assert_in_epsilon vector.z, 0.80178, 0.00001
  end

  test "normalized tuple's magnitude is always 1.0" do
    vector = Vector.new(1, 2, 3).normalize
    assert_equal vector.magnitude, 1.0

    vector = Vector.new(-1, -2, -3).normalize
    assert_equal vector.magnitude, 1.0
  end

  test '#dot' do
    vector1 = Vector.new(1, 2, 3)
    vector2 = Vector.new(2, 3, 4)
    result = vector1.dot(vector2)

    assert_equal result, 20
  end

  test '#cross' do
    vector1 = Vector.new(1, 2, 3)
    vector2 = Vector.new(2, 3, 4)

    result1 = vector1.cross(vector2)
    assert_equal result1, Vector.new(-1, 2, -1)

    result2 = vector2.cross(vector1)
    assert_equal result2, Vector.new(1, -2, 1)
  end

end
