require_relative '../test_helper'
require_relative '../../lib/matrix'
require_relative '../../lib/point'
require_relative '../../lib/vector'

class TranslationsTest < Minitest::Test

  test '.translate creates a translation matrix' do
    translate = Matrix.new([
      [1, 0, 0, 2],
      [0, 1, 0, 3],
      [0, 0, 1, 4],
      [0, 0, 0, 1]
    ])

    assert_equal translate, Matrix.translate(2, 3, 4)
  end

  test '#translate multiplies by a translation matrix' do
    translate = Matrix.new([
      [1, 0, 0, 2],
      [0, 1, 0, 3],
      [0, 0, 1, 4],
      [0, 0, 0, 1]
    ])

    assert_equal translate, Matrix.identity.translate(2, 3, 4)
  end

  test '#translate moves a point' do
    transform = Matrix.translate(5, -3, 2)
    point = Point.new(-3, 4, 5)

    assert_equal Point.new(2, 1, 7), transform * point
  end

  test 'inverted translate moves in a negative direction' do
    transform = Matrix.translate(5, -3, 2)
    inverse = transform.inverse
    point = Point.new(-3, 4, 5)

    assert_equal Point.new(-8, 7, 3), inverse * point
    end

  test '#translate with a vector has no effect' do
    transform = Matrix.translate(5, -3, 2)
    vector = Vector.new(-3, 4, 5)

    assert_equal vector, transform * vector
  end

end
