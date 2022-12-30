require_relative './test_helper'

class CameraTest < Minitest::Test

  test 'constructing a camera' do
    hsize = 160
    vsize = 120
    field_of_view = Math::PI / 2
    camera = Camera.new(hsize, vsize, field_of_view)

    assert_equal hsize, camera.hsize
    assert_equal vsize, camera.vsize
    assert_equal field_of_view, camera.field_of_view
    assert_equal Matrix.identity, camera.transform
  end

  test 'the pixel size for a horizontal canvas' do
    camera = Camera.new(200, 125, Math::PI / 2)

    assert_in_delta 0.01, camera.pixel_size, 0.00001
  end

  test 'the pixel size for a vertical canvas' do
    camera = Camera.new(125, 200, Math::PI / 2)

    assert_in_delta 0.01, camera.pixel_size, 0.00001
  end

  test 'constructing a ray through the center of the canvas' do
    camera = Camera.new(201, 101, Math::PI / 2)
    ray = camera.ray_for_pixel(100, 50)

    assert_equal Point.origin, ray.origin
    assert_equal Vector.new(0, 0, -1), ray.direction
  end

  test 'constructing a ray through a corner of the canvas' do
    camera = Camera.new(201, 101, Math::PI / 2)
    ray = camera.ray_for_pixel(0, 0)

    assert_equal Point.origin, ray.origin
    assert_equal Vector.new(0.66519, 0.33259, -0.66851), ray.direction
  end

  test 'constructing a ray when the camera is transformed' do
    camera = Camera.new(201, 101, Math::PI / 2)
    camera.transform = Matrix.rotate_y(Math::PI / 4) * Matrix.translate(0, -2, 5)
    ray = camera.ray_for_pixel(100, 50)

    assert_equal Point.new(0, 2, -5), ray.origin
    assert_equal Vector.new(Math.sqrt(2) / 2, 0, -Math.sqrt(2) / 2), ray.direction
  end

  test 'rendering a world with a camera' do
    light = PointLight.new(Point.new(-10, 10, -10), Color.white)
    sphere1 = Sphere.new
    sphere1.material = Material.new(color: Color.new(0.8, 1.0, 0.6),
                                    diffuse: 0.7,
                                    specular: 0.2)
    sphere2 = Sphere.new
    sphere2.transform = Matrix.scale(0.5, 0.5, 0.5)
    world = World.new
    world.add_light(light)
    world.add_object(sphere1)
    world.add_object(sphere2)
    camera = Camera.new(11, 11, Math::PI / 2)
    from = Point.new(0, 0, -5)
    to = Point.new(0, 0, 0)
    up = Vector.new(0, 1, 0)
    camera.transform = View.transform(from, to, up)
    image = camera.render(world)

    assert_equal Color.new(0.38066, 0.47583, 0.2855), image.read(5, 5)
  end

end
