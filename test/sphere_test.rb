require_relative './test_helper'

class ShapeTest < Minitest::Test

  test 'the normal on a sphere at a point on the x axis' do
    sphere = Sphere.new

    assert_equal Vector.new(1, 0, 0), sphere.normal_at(Point.new(1, 0, 0))
  end

  test 'the normal on a sphere at a point on the y axis' do
    sphere = Sphere.new

    assert_equal Vector.new(0, 1, 0), sphere.normal_at(Point.new(0, 1, 0))
  end

  test 'the normal on a sphere at a point on the z axis' do
    sphere = Sphere.new

    assert_equal Vector.new(0, 0, 1), sphere.normal_at(Point.new(0, 0, 1))
  end

  test 'the normal on a sphere at a nonaxial point' do
    sphere = Sphere.new
    loc = Math.sqrt(3) / 3

    assert_equal Vector.new(loc, loc, loc), sphere.normal_at(Point.new(loc, loc, loc))
  end

  test 'computing the normal on a translated sphere' do
    sphere = Sphere.new
    sphere.transform = Matrix.translate(0, 1, 0)

    assert_equal Vector.new(0, 0.70711, -0.70711), sphere.normal_at(Point.new(0, 1.70711, -0.70711))
  end

  test 'computing the normal on a transformed sphere' do
    sphere = Sphere.new
    sphere.transform = Matrix.scale(1, 0.5, 1) * Matrix.rotate_z(Math::PI / 5)

    assert_equal Vector.new(0, 0.97014, -0.24254), sphere.normal_at(Point.new(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2))
  end

end
