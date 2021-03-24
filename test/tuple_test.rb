require_relative './test_helper'
require_relative '../tuple'

class TupleTest < Minitest::Test

  test '#initialize' do
    tuple = Tuple.new(4.3, -4.2, 3.1, 1.0)

    assert_instance_of Tuple, tuple
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 1.0
  end

  test '#initialize a point by name' do
    tuple = Tuple.new(4.3, -4.2, 3.1, :point)

    assert tuple.point?
  end

  test '#initialize a vector by name' do
    tuple = Tuple.new(4.3, -4.2, 3.1, :vector)

    assert tuple.vector?
  end

  test '#initialize with an unknown name raises an error' do
    assert_raises(StandardError) { Tuple.new(4.3, -4.2, 3.1, :foobar) }
  end

  test '#initialize converts everything to floats' do
    tuple = Tuple.new(4, -4, 3, 0)

    assert_equal tuple.x, 4.0
    assert_equal tuple.y, -4.0
    assert_equal tuple.z, 3.0
    assert_equal tuple.w, 0.0
  end

  test 'equality' do
    tuple1 = Tuple.new(4.3, -4.2, 3.1, 0.0)
    tuple2 = Tuple.new(4.3, -4.2, 3.1, 0.0)
    tuple3 = Tuple.new(3.4, -2.4, 1.3, 0.0)

    assert tuple1 == tuple2
    assert tuple1 != tuple3
  end

  test '#to_a' do
    tuple = Tuple.new(4.3, -4.2, 3.1, 1.0)

    assert_equal tuple.to_a, [4.3, -4.2, 3.1, 1.0]
  end

  test 'adding a point and a vector is a point' do
    tuple1 = Tuple.new(3, -2, 5, 1.0)
    tuple2 = Tuple.new(-2, 3, 1, 0.0)
    total = tuple1 + tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(1, 1, 6, 1.0)
  end

  test 'adding two vectors is a vector' do
    tuple1 = Tuple.new(3, -2, 5, 0.0)
    tuple2 = Tuple.new(-2, 3, 1, 0.0)
    total = tuple1 + tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(1, 1, 6, 0.0)
  end

  test 'subtracting two points equals a vector' do
    point1 = Tuple.new(3, 2, 1, 1.0)
    point2 = Tuple.new(5, 6, 7, 1.0)
    total = point1 - point2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 0.0)
    assert total.vector?
  end

  test 'subtracting two vectors equals a vector' do
    vector1 = Tuple.new(3, 2, 1, 0.0)
    vector2 = Tuple.new(5, 6, 7, 0.0)
    total = vector1 - vector2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 0.0)
    assert total.vector?
  end

  test 'subtracting a vector from a point equals a point' do
    tuple1 = Tuple.new(3, 2, 1, 1.0)
    tuple2 = Tuple.new(5, 6, 7, 0.0)
    total = tuple1 - tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 1.0)
    assert total.point?
  end

  test 'negating a tuple' do
    tuple = Tuple.new(1, -2, 3, 0.0)

    assert_equal(-tuple, Tuple.new(-1, 2, -3, 0.0))
  end

  test 'multiplying a tuple by a scalar' do
    tuple = Tuple.new(1, -2, 3, -4)
    total = tuple * 3.5

    assert_equal total, Tuple.new(3.5, -7, 10.5, -14.0)
  end

  test 'multiplying a tuple by a fraction' do
    tuple = Tuple.new(1, -2, 3, -4)
    total = tuple * 0.5

    assert_equal total, Tuple.new(0.5, -1, 1.5, -2.0)
  end

  test 'dividing a tuple by a scalar' do
    tuple = Tuple.new(1, -2, 3, -4)
    total = tuple / 2

    assert_equal total, Tuple.new(0.5, -1, 1.5, -2.0)
  end

  test '#magnitude' do
    vector = Tuple.new(1, 0, 0, :vector)
    assert_equal vector.magnitude, 1.0

    vector = Tuple.new(0, 1, 0, :vector)
    assert_equal vector.magnitude, 1.0

    vector = Tuple.new(0, 0, 1, :vector)
    assert_equal vector.magnitude, 1.0

    vector = Tuple.new(1, 2, 3, :vector)
    assert_equal vector.magnitude, Math.sqrt(14)

    vector = Tuple.new(-1, -2, -3, :vector)
    assert_equal vector.magnitude, Math.sqrt(14)
  end

  test '#normalize' do
    vector = Tuple.new(4, 0, 0, :vector).normalize
    assert_equal vector, Tuple.new(1, 0, 0, :vector)

    vector = Tuple.new(1, 2, 3, :vector).normalize
    assert_in_epsilon vector.x, 0.26726, 0.00001
    assert_in_epsilon vector.y, 0.53452, 0.00001
    assert_in_epsilon vector.z, 0.80178, 0.00001
  end

  test "normalized tuple's magnitude is always 1.0" do
    vector = Tuple.new(1, 2, 3, :vector).normalize
    assert_equal vector.magnitude, 1.0

    vector = Tuple.new(-1, -2, -3, :vector).normalize
    assert_equal vector.magnitude, 1.0
  end

  test '#dot' do
    vector1 = Tuple.new(1, 2, 3, :vector)
    vector2 = Tuple.new(2, 3, 4, :vector)
    result = vector1.dot(vector2)

    assert_equal result, 20
  end

  test '#cross' do
    vector1 = Tuple.new(1, 2, 3, :vector)
    vector2 = Tuple.new(2, 3, 4, :vector)

    result1 = vector1.cross(vector2)
    assert_equal result1, Tuple.new(-1, 2, -1, :vector)

    result2 = vector2.cross(vector1)
    assert_equal result2, Tuple.new(1, -2, 1, :vector)
  end
end
