require 'minitest/autorun'
require_relative '../point'

class TupleTest < Minitest::Test

  def test_tuple_initialization
    tuple = Tuple.new(4.3, -4.2, 3.1)

    assert_equal tuple.class, Tuple
    assert_equal tuple.x, 4.3
    assert_equal tuple.y, -4.2
    assert_equal tuple.z, 3.1
  end

  def test_tuple_to_array
    tuple = Tuple.new(4.3, -4.2, 3.1)

    assert_equal tuple.to_a, [4.3, -4.2, 3.1]
  end

end
