require_relative '../../lib/rubyray'

world = World.new

# room
floor = Sphere.new
floor.transform = Matrix.scale(10, 0.01, 10)
floor.material.color = Color.new(1, 0.9, 0.9)
floor.material.specular = 0

left_wall = Sphere.new
# left_wall.transform = Matrix.translate(0, 0, 5) * Matrix.rotate_y(-Math::PI / 4) * Matrix.rotate_x(Math::PI / 2) * Matrix.scale(10, 0.01, 10)
left_wall.transform = Matrix.scale(10, 0.01, 10).rotate_x(Math::PI / 2).rotate_y(-Math::PI / 4).translate(0, 0, 5)

right_wall = Sphere.new
# right_wall.transform = Matrix.translate(0, 0, 5) * Matrix.rotate_y(Math::PI / 4) * Matrix.rotate_x(Math::PI / 2) * Matrix.scale(10, 0.01, 10)
right_wall.transform = Matrix.scale(10, 0.01, 10).rotate_x(Math::PI / 2).rotate_y(Math::PI / 4).translate(0, 0, 5)

world.add_objects(floor, left_wall, right_wall)

# balls
middle = Sphere.new
middle.transform = Matrix.translate(-0.5, 1, 0.5)
middle.material.color = Color.new(1, 0.1, 0.2)
middle.material.diffuse = 0.7
middle.material.specular = 0.3

right = Sphere.new
# right.transform = Matrix.translate(1.5, 0.5, -0.5) * Matrix.scale(0.5, 0.5, 0.5)
right.transform = Matrix.scale(0.5, 0.5, 0.5).translate(1.5, 0.5, -0.5)
right.material.color = Color.new(0.2, 1, 0.1)
right.material.diffuse = 0.5
right.material.specular = 0.5

left = Sphere.new
# left.transform = Matrix.translate(-1.5, 0.33, -0.75) * Matrix.scale(0.33, 0.33, 0.33)
left.transform = Matrix.scale(0.33, 0.33, 0.33).translate(-1.5, 0.33, -0.75)
left.material.color = Color.new(0.1, 0.2, 1)
left.material.diffuse = 0.8
left.material.specular = 0.7

world.add_objects(middle, right, left)

# the light
light = PointLight.new(Point.new(-10, 10, -10), Color.white)
world.add_light(light)

# render it
camera = Camera.new(100, 50, Math::PI / 3)
camera.transform = View.transform(Point.new(0, 1.5, -5), Point.new(0, 1, 0), Vector.new(0, 1, 0))
canvas = camera.render(world, progress: true, processes: 8)

canvas.to_ppm(File.join(File.expand_path(File.dirname(__FILE__)), "render-#{camera.hsize}x#{camera.vsize}"))
