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
    tuple4 = Tuple.new(3.4, -2.4, 1.3, 1)

    assert tuple1 == tuple2
    assert tuple1 != tuple3
    assert tuple3 != tuple4
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

  test '#to_point' do
    assert_equal Point.new(1,2,3), Tuple.new(1,2,3,1).to_point

    # converts to point even if it has a different w
    assert_equal Point.new(1, 2, 3), Vector.new(1, 2, 3).to_point
  end

  test '#to_vector' do
    tuple =
    assert_equal Vector.new(3,4,5), Tuple.new(3,4,5,0).to_vector

    # converts to vector even if it has a different w
    assert_equal Vector.new(1, 2, 3), Point.new(1, 2, 3).to_vector
  end

  test '#point?' do
    assert Tuple.new(1,2,3,1).point?
    assert !Tuple.new(1,2,3,0).point?
  end

  test '#vector?' do
    assert Tuple.new(1,2,3,0).vector?
    assert !Tuple.new(1,2,3,1).vector?
  end

  test '#type' do
    assert_equal :point, Tuple.new(1,2,3,1).type
    assert_equal :vector, Tuple.new(1,2,3,0).type
    assert_equal :unknown, Tuple.new(1,2,3,2).type
  end

  test '#to_concrete_type' do
    assert_equal Point.new(1,2,3), Tuple.new(1,2,3,1).to_concrete_type
    assert_equal Vector.new(1,2,3), Tuple.new(1,2,3,0).to_concrete_type

    tuple = Tuple.new(1,2,3,2)
    assert_equal tuple, tuple.to_concrete_type
  end

end
