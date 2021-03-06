require_relative './test_helper'
require_relative '../lib/tuple'

class TupleTest < Minitest::Test

  test '#initialize' do
    tuple = Tuple.new(4.3, -4.2, 3.1, 1.0)

    assert_instance_of Tuple, tuple
    assert_equal(4.3, tuple.x)
    assert_equal(-4.2, tuple.y)
    assert_equal(3.1, tuple.z)
    assert_equal(1.0, tuple.w)
  end

  test '#initialize converts everything to floats' do
    tuple = Tuple.new(4, -4, 3, 0)

    assert_equal(4.0, tuple.x)
    assert_equal(-4.0, tuple.y)
    assert_equal(3.0, tuple.z)
    assert_equal(0.0, tuple.w)
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

    assert_equal [4.3, -4.2, 3.1, 1.0], tuple.to_a
  end

  test 'adding two tuples' do
    tuple1 = Tuple.new(3, -2, 5)
    tuple2 = Tuple.new(-2, 3, 1)
    result = tuple1 + tuple2

    assert_instance_of Tuple, result
    assert_equal Tuple.new(1, 1, 6), result
  end

  test 'subtracting two tuples' do
    point1 = Tuple.new(3, 2, 1)
    point2 = Tuple.new(5, 6, 7)
    result = point1 - point2

    assert_instance_of Tuple, result
    assert_equal Tuple.new(-2, -4, -6), result
  end

  test 'multiplying a tuple by a scalar' do
    tuple = Tuple.new(1, -2, 3, -4)
    result = tuple * 3.5

    assert_instance_of Tuple, result
    assert_equal Tuple.new(3.5, -7, 10.5, -14.0), result
  end

  test 'multiplying a tuple by a fraction' do
    tuple = Tuple.new(1, -2, 3, -4)
    result = tuple * 0.5

    assert_instance_of Tuple, result
    assert_equal Tuple.new(0.5, -1, 1.5, -2.0), result
  end

  test 'dividing a tuple by a scalar' do
    tuple = Tuple.new(1, -2, 3, -4)
    result = tuple / 2

    assert_instance_of Tuple, result
    assert_equal Tuple.new(0.5, -1, 1.5, -2.0), result
  end

  test 'negating a tuple' do
    tuple = Tuple.new(1, -2, 3, -4)

    assert_instance_of Tuple, tuple
    assert_equal(Tuple.new(-1, 2, -3, 4), -tuple)
  end

end
