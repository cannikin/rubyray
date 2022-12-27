require_relative './test_helper'
require_relative '../lib/shape'

require_relative '../lib/point'
require_relative '../lib/matrix'

class ShapeTest < Minitest::Test

  test 'each shape gets a unique id' do
    shape1 = Shape.new
    shape2 = Shape.new
    shape3 = Shape.new
    start_id = shape1.id

    assert_equal start_id + 1, shape2.id
    assert_equal start_id + 2, shape3.id
  end

  test 'a shape is created at the origin' do
    assert_equal Point.new(0, 0, 0), Shape.new.origin
  end

  test "a shape's default transformation" do
    shape = Shape.new

    assert_equal Matrix.identity, Shape.new.transform
  end

  test "changing a shape's transformation" do
    shape = Shape.new
    transform = Matrix.translate(2, 3, 4)
    shape.transform = transform

    assert_equal transform, shape.transform
  end

end