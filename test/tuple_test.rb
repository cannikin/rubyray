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

  test 'adding two tuples' do
    tuple1 = Tuple.new(3, -2, 5)
    tuple2 = Tuple.new(-2, 3, 1)
    total = tuple1 + tuple2

    assert_equal total, Tuple.new(1, 1, 6)
  end

  test 'subtracting two tuples' do
    point1 = Tuple.new(3, 2, 1)
    point2 = Tuple.new(5, 6, 7)
    total = point1 - point2

    assert_equal total, Tuple.new(-2, -4, -6)
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

  test 'negating a tuple' do
    tuple = Tuple.new(1, -2, 3, -4)

    assert_equal(-tuple, Tuple.new(-1, 2, -3, 4))
  end

end
