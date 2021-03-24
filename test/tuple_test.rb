require 'minitest/autorun'

class TupleTest < Minitest::Test

  def test_tuple_initialization
    tuple = Tuple.new(4.3, -4.2, 3.1, 1.0)

    assert_instance_of Tuple, tuple
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
    assert_equal tuple.w, 1.0
  end

  def test_tuple_equality
    tuple1 = Tuple.new(4.3, -4.2, 3.1, 0.0)
    tuple2 = Tuple.new(4.3, -4.2, 3.1, 0.0)
    tuple3 = Tuple.new(3.4, -2.4, 1.3, 0.0)

    assert tuple1 == tuple2
    assert tuple1 != tuple3
  end

  def test_tuple_to_array
    tuple = Tuple.new(4.3, -4.2, 3.1, 1.0)

    assert_equal tuple.to_a, [4.3, -4.2, 3.1, 1.0]
  end

  def test_tuple_addition
    tuple1 = Tuple.new(3, -2, 5, 1.0)
    tuple2 = Tuple.new(-2, 3, 1, 0.0)
    total = tuple1 + tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(1, 1, 6, 1.0)

    # original tuples are not changed
    assert_equal tuple1, Tuple.new(3, -2, 5, 1.0)
    assert_equal tuple2, Tuple.new(-2, 3, 1, 0.0)
  end

  def test_tuple_subtraction
    tuple1 = Tuple.new(3, 2, 1, 1.0)
    tuple2 = Tuple.new(5, 6, 7, 1.0)
    total = tuple1 - tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 0.0)
  end

end
