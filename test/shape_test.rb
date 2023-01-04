require_relative 'test_helper'

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
    assert_equal Matrix.identity, Shape.new.transform
  end

  test "changing a shape's transformation" do
    shape = Shape.new
    transform = Matrix.translate(2, 3, 4)
    shape.transform = transform

    assert_equal transform, shape.transform
  end

  test 'a shape has a default material' do
    shape = Shape.new
    material = Material.new

    assert_instance_of Material, shape.material
    assert_equal material.color, shape.material.color
  end

  test 'a shape may be assigned a material' do
    shape = Shape.new
    material = Material.new(color: Color.new(1, 0, 0))
    shape.material = material

    assert_equal material, shape.material
  end

  test 'the normal on a shape at a point on the x axis' do
    shape = Shape.new

    assert_equal Vector.new(1, 0, 0), shape.normal_at(Point.new(1, 0, 0))
  end

  test 'the normal on a shape at a point on the y axis' do
    shape = Shape.new

    assert_equal Vector.new(0, 1, 0), shape.normal_at(Point.new(0, 1, 0))
  end

  test 'the normal on a shape at a point on the z axis' do
    shape = Shape.new

    assert_equal Vector.new(0, 0, 1), shape.normal_at(Point.new(0, 0, 1))
  end

  test 'the normal on a shape at a nonaxial point' do
    shape = Shape.new
    loc = Math.sqrt(3) / 3

    assert_equal Vector.new(loc, loc, loc), shape.normal_at(Point.new(loc, loc, loc))
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

  test 'intersecting a scaled shape with a ray' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    shape = Shape.new
    shape.transform = Matrix.scale(2, 2, 2)

    assert_equal Point.new(0, 0, -2.5), shape.local_ray(ray).origin
    assert_equal Vector.new(0, 0, 0.5), shape.local_ray(ray).direction
  end

  test 'intersecting a translated shape with a ray' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    shape = Shape.new
    shape.transform = Matrix.translate(5, 0, 0)

    assert_equal Point.new(-5, 0, -5), shape.local_ray(ray).origin
    assert_equal Vector.new(0, 0, 1), shape.local_ray(ray).direction
  end

  test 'hit returns the intersection hit' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.scale(2, 2, 2)
    intersections = sphere.intersect(ray)

    assert_equal intersections.hit.t, sphere.hit(ray).t
  end

  test 'hit? convenience function' do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.scale(2, 2, 2)
    assert sphere.hit?(ray)

    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    sphere = Sphere.new
    sphere.transform = Matrix.translate(5, 0, 0)
    assert !sphere.hit?(ray)
  end

end
