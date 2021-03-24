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

  def test_tuple_initialize_converts_everything_to_floats
    tuple = Tuple.new(4, -4, 3, 0)

    assert_equal tuple.x, 4.0
    assert_equal tuple.y, -4.0
    assert_equal tuple.z, 3.0
    assert_equal tuple.w, 0.0
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

  def test_adding_a_point_and_a_vector_is_a_point
    tuple1 = Tuple.new(3, -2, 5, 1.0)
    tuple2 = Tuple.new(-2, 3, 1, 0.0)
    total = tuple1 + tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(1, 1, 6, 1.0)
  end

  def test_adding_two_vectors_is_a_vector
    tuple1 = Tuple.new(3, -2, 5, 0.0)
    tuple2 = Tuple.new(-2, 3, 1, 0.0)
    total = tuple1 + tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(1, 1, 6, 0.0)
  end

  def test_subtracting_two_points_equals_a_vector
    point1 = Tuple.new(3, 2, 1, 1.0)
    point2 = Tuple.new(5, 6, 7, 1.0)
    total = point1 - point2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 0.0)
    assert total.vector?
  end

  def test_subtracting_two_vectors_equals_a_vector
    vector1 = Tuple.new(3, 2, 1, 0.0)
    vector2 = Tuple.new(5, 6, 7, 0.0)
    total = vector1 - vector2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 0.0)
    assert total.vector?
  end

  def test_subtracting_a_vector_from_a_point_equals_a_point
    tuple1 = Tuple.new(3, 2, 1, 1.0)
    tuple2 = Tuple.new(5, 6, 7, 0.0)
    total = tuple1 - tuple2

    assert_instance_of Tuple, total
    assert_equal total, Tuple.new(-2, -4, -6, 1.0)
    assert total.point?
  end

  def test_negating_a_tuple
    tuple = Tuple.new(1, -2, 3, 0.0)

    assert_equal(-tuple, Tuple.new(-1, 2, -3, 0.0))
  end

  def test_multiplying_a_tuple_by_a_scalar
    tuple = Tuple.new(1, -2, 3, -4)
    total = tuple * 3.5

    assert_equal total, Tuple.new(3.5, -7, 10.5, -14.0)
  end

  def test_multiplying_a_tuple_by_a_fraction
    tuple = Tuple.new(1, -2, 3, -4)
    total = tuple * 0.5

    assert_equal total, Tuple.new(0.5, -1, 1.5, -2.0)
  end

end
