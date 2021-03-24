require_relative './test_helper'

class TupleTest < Minitest::Test

  test 'tuple initialization' do
    tuple = Tuple.new(4.3, -4.2, 3.1, 1.0)

    assert_instance_of Tuple, tuple
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 1.0
  end

  test 'initialize converts everything to floats' do
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

  test 'tuple to array' do
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
end
