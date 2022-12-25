require_relative '../test_helper'
require_relative '../../lib/matrix'
require_relative '../../lib/point'
require_relative '../../lib/vector'

class TranslationsTest < Minitest::Test

  test '.translate creates a translation matrix' do
    transform = Matrix.new([
      [1, 0, 0, 2],
      [0, 1, 0, 3],
      [0, 0, 1, 4],
      [0, 0, 0, 1]
    ])

    assert_equal transform, Matrix.translate(2, 3, 4)
  end

  test '#translate multiplies by a translation matrix' do
    transform = Matrix.new([
      [1, 0, 0, 2],
      [0, 1, 0, 3],
      [0, 0, 1, 4],
      [0, 0, 0, 1]
    ])

    assert_equal transform, Matrix.identity.translate(2, 3, 4)
  end

  test 'translate applied to a point' do
    transform = Matrix.translate(5, -3, 2)
    point = Point.new(-3, 4, 5)

    assert_equal Point.new(2, 1, 7), transform * point
  end

  test 'multiplying by the inverse of a translation matrix' do
    transform = Matrix.translate(5, -3, 2)
    inverse = transform.inverse
    point = Point.new(-3, 4, 5)

    assert_equal Point.new(-8, 7, 3), inverse * point
    end

  test 'translate does not affect vectors' do
    transform = Matrix.translate(5, -3, 2)
    vector = Vector.new(-3, 4, 5)

    assert_equal vector, transform * vector
  end

  test '.scale creates a scaling matrix' do
    transform = Matrix.new([
      [2, 0, 0, 0],
      [0, 3, 0, 0],
      [0, 0, 4, 0],
      [0, 0, 0, 1]
    ])

    assert_equal transform, Matrix.scale(2, 3, 4)
  end

  test '#scale multiplies by a translation matrix' do
    transform = Matrix.new([
      [2, 0, 0, 0],
      [0, 3, 0, 0],
      [0, 0, 4, 0],
      [0, 0, 0, 1]
    ])

    assert_equal transform, Matrix.identity.scale(2, 3, 4)
  end

  test 'scaling applied to a point' do
    transform = Matrix.scale(2, 3, 4)
    point = Point.new(-4, 6, 8)

    assert_equal Point.new(-8, 18, 32), transform * point
  end

  test 'scaling applied to a vector' do
    transform = Matrix.scale(2, 3, 4)
    vector = Vector.new(-4, 6, 8)

    assert_equal Vector.new(-8, 18, 32), transform * vector
  end

  test 'multiplying by the inverse of a scaling matrix' do
    transform = Matrix.scale(2, 3, 4)
    inverse = transform.inverse
    point = Point.new(-4, 6, 8)

    assert_equal Point.new(-2, 2, 2), inverse * point
  end

  test 'reflection is scaling by a negative value' do
    transform = Matrix.scale(-1, 1, 1)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(-2, 3, 4), transform * point
  end

  test 'rotating a point around the x axis' do
    point = Point.new(0, 1, 0)
    half_quarter = Matrix.rotate_x(Math::PI / 4)
    full_quarter = Matrix.rotate_x(Math::PI / 2)

    assert_equal Point.new(0, Math.sqrt(2) / 2, Math.sqrt(2) / 2), half_quarter * point
    assert_equal Point.new(0, 0, 1), full_quarter * point
  end

  test 'inverse of an x rotation rotates in the opposite direction' do
    point = Point.new(0, 1, 0)
    half_quarter = Matrix.rotate_x(Math::PI / 4)

    assert_equal Point.new(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2), half_quarter.inverse * point
  end

  test 'rotating a point around the y axis' do
    point = Point.new(0, 0, 1)
    half_quarter = Matrix.rotate_y(Math::PI / 4)
    full_quarter = Matrix.rotate_y(Math::PI / 2)

    assert_equal Point.new(Math.sqrt(2) / 2, 0, Math.sqrt(2) / 2), half_quarter * point
    assert_equal Point.new(1, 0, 0), full_quarter * point
  end

  test 'rotating a point around the z axis' do
    point = Point.new(0, 1, 0)
    half_quarter = Matrix.rotate_z(Math::PI / 4)
    full_quarter = Matrix.rotate_z(Math::PI / 2)

    assert_equal Point.new(-Math.sqrt(2) / 2, Math.sqrt(2) / 2, 0), half_quarter * point
    assert_equal Point.new(-1, 0, 0), full_quarter * point
  end

  test 'shearing transformation moves x in proportion to y' do
    transform = Matrix.shear(1, 0, 0, 0, 0, 0)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(5, 3, 4), transform * point
  end

  test 'shearing transformation moves x in proportion to z' do
    transform = Matrix.shear(0, 1, 0, 0, 0, 0)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(6, 3, 4), transform * point
  end

  test 'shearing transformation moves y in proportion to x' do
    transform = Matrix.shear(0, 0, 1, 0, 0, 0)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(2, 5, 4), transform * point
  end

  test 'shearing transformation moves y in proportion to z' do
    transform = Matrix.shear(0, 0, 0, 1, 0, 0)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(2, 7, 4), transform * point
  end

  test 'shearing transformation moves z in proportion to x' do
    transform = Matrix.shear(0, 0, 0, 0, 1, 0)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(2, 3, 6), transform * point
  end

  test 'shearing transformation moves z in proportion to y' do
    transform = Matrix.shear(0, 0, 0, 0, 0, 1)
    point = Point.new(2, 3, 4)

    assert_equal Point.new(2, 3, 7), transform * point
  end

  test 'individual transformations are applied in sequence' do
    point = Point.new(1, 0, 1)
    rotation = Matrix.rotate_x(Math::PI / 2)
    scale = Matrix.scale(5, 5, 5)
    translate = Matrix.translate(10, 5, 7)

    point2 = rotation * point
    assert_equal Point.new(1, -1, 0), point2

    point3 = scale * point2
    assert_equal Point.new(5, -5, 0), point3

    point4 = translate * point3
    assert_equal Point.new(15, 0, 7), point4
  end

  test 'chained transformations are applied in reverse order' do
    point = Point.new(1, 0, 1)
    transform = Matrix.rotate_x(Math::PI / 2).scale(5, 5, 5).translate(10, 5, 7)

    assert_equal Point.new(15, 0, 7), transform * point
  end

end
