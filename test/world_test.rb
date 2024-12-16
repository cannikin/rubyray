require_relative "test_helper"

class WorldTest < Minitest::Test
  def setup
    @light = PointLight.new(Point.new(-10, 10, -10), Color.white)
    @sphere1 = Sphere.new
    @sphere1.material = Material.new(color: Color.new(0.8, 1.0, 0.6),
      diffuse: 0.7,
      specular: 0.2)
    @sphere2 = Sphere.new
    @sphere2.transform = Matrix.scale(0.5, 0.5, 0.5)
    @default_world = World.new
    @default_world.add_light(@light)
    @default_world.add_object(@sphere1)
    @default_world.add_object(@sphere2)
  end

  test "creating a world" do
    world = World.new

    assert_empty world.objects
    assert_empty world.lights
  end

  test "the default world" do
    assert_includes @default_world.lights, @light
    assert_includes @default_world.objects, @sphere1
    assert_includes @default_world.objects, @sphere2
  end

  test "intersect a world with a ray" do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    intersections = @default_world.intersect(ray)

    assert_equal 4, intersections.size
    assert_equal 4, intersections[0].t
    assert_equal 4.5, intersections[1].t
    assert_equal 5.5, intersections[2].t
    assert_equal 6, intersections[3].t
  end

  test "shading an intersection" do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))
    intersection = Intersection.new(4, @sphere1, ray)
    comps = intersection.prepare_computations

    assert_equal Color.new(0.38066, 0.47583, 0.2855), @default_world.shade_hit(comps)
  end

  test "shading an intersection from the inside" do
    @default_world.reset_lights
    light = PointLight.new(Point.new(0, 0.25, 0), Color.white)
    @default_world.add_light(light)
    ray = Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1))
    intersection = Intersection.new(0.5, @sphere2, ray)
    comps = intersection.prepare_computations

    assert_equal Color.new(0.90498, 0.90498, 0.90498), @default_world.shade_hit(comps)
  end

  test "shade_hit is given an intersection in shadow" do
    world = World.new
    world.add_light(PointLight.new(Point.new(0, 0, -10), Color.white))
    sphere1 = Sphere.new
    sphere2 = Sphere.new
    sphere2.transform = Matrix.translate(0, 0, 10)
    world.add_objects(sphere1, sphere2)
    ray = Ray.new(Point.new(0, 0, 5), Vector.new(0, 0, 1))
    intersection = Intersection.new(4, sphere2, ray)
    comps = intersection.prepare_computations
    color = world.shade_hit(comps)

    assert_equal Color.new(0.1, 0.1, 0.1), color
  end

  test "the color when a ray misses" do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 1, 0))

    assert_equal Color.black, @default_world.color_at(ray)
  end

  test "the color when a ray hits" do
    ray = Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1))

    assert_equal Color.new(0.38066, 0.47583, 0.2855), @default_world.color_at(ray)
  end

  test "the color with an intersection behind the ray" do
    @sphere1.material.ambient = 1
    @sphere2.material.ambient = 1
    ray = Ray.new(Point.new(0, 0, 0.75), Vector.new(0, 0, -1))

    assert_equal @sphere2.material.color, @default_world.color_at(ray)
  end

  test "there is no shadow when nothing is collinear with point and light" do
    assert !@default_world.shadowed?(Point.new(0, 10, 0))
  end

  test "the shadow when an object is between the point and the light" do
    assert @default_world.shadowed?(Point.new(10, -10, 10))
  end

  test "there is no shadow when an object is behind the light" do
    assert !@default_world.shadowed?(Point.new(-20, 20, -20))
  end

  test "there is no shadow when an object is behind the point" do
    assert !@default_world.shadowed?(Point.new(-2, 2, -2))
  end
end
