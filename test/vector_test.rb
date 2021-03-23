require 'minitest/autorun'
require_relative '../vector'

class VectorTest < Minitest::Test

  def test_vector_initialization
    vector = Vector.new(4.3, -4.2, 3.1)

    assert_equal vector.class, Vector
    assert_equal vector.x, 4.3
    assert_equal vector.y, -4.2
    assert_equal vector.z, 3.1
    assert_equal vector.w, 0.0
  end

  def test_vector_to_array
    vector = Vector.new(4.3, -4.2, 3.1)

    assert_equal vector.to_a, [4.3, -4.2, 3.1, 0.0]
  end

end
