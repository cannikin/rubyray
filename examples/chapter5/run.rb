require_relative '../../lib/point'
require_relative '../../lib/ray'
require_relative '../../lib/sphere'
require_relative '../../lib/canvas'

ray_origin = Point.new(0, 0, -5)
wall_z = 10
wall_size = 7.0
canvas_pixels = 100
pixel_size = wall_size / canvas_pixels # 0.07
half = wall_size / 2                   # 3.5

canvas = Canvas.new(canvas_pixels, canvas_pixels)
red = Color.new(1, 0, 0)
sphere = Sphere.new
# sphere.transform = Matrix.rotate_z(Math::PI / 4) * Matrix.scale(0.5, 1, 1)
# sphere.transform = Matrix.shear(0.5, 0, 0, 0, 0, 0)# * Matrix.scale(0.5, 1, 1)

canvas_pixels.times do |y|
  # translate the tiny world space (only 7 units wide) to the canvas (100 pixels wide)
  world_y = half - pixel_size * y

  canvas_pixels.times do |x|
    print '.'

    world_x = -half + pixel_size * x

    position = Point.new(world_x, world_y, wall_z)
    ray = Ray.new(ray_origin, (position - ray_origin).normalize)

    if ray.hit?(sphere)
      canvas.write(x, y, red)
    end
  end
end

path = canvas.to_ppm(File.join(File.expand_path(File.dirname(__FILE__)), 'chapter5'))
`open #{path}`
