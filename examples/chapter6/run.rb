require_relative '../../lib/point'
require_relative '../../lib/ray'
require_relative '../../lib/sphere'
require_relative '../../lib/color'
require_relative '../../lib/point_light'
require_relative '../../lib/lighting'
require_relative '../../lib/canvas'

ray_origin = Point.new(0, 0, -5)
wall_z = 10
wall_size = 7.0
canvas_pixels = 100
pixel_size = wall_size / canvas_pixels # 0.07
half = wall_size / 2                   # 3.5
canvas = Canvas.new(canvas_pixels, canvas_pixels)

# the object
sphere = Sphere.new
sphere.material = Material.new
sphere.material.color = Color.new(1, 0.2, 1)

# the light
light = PointLight.new(Point.new(-10, 10, -10), Color.white)

start_time = Time.now

canvas_pixels.times do |y|
  # translate the tiny world space (only 7 units wide) to the canvas (100 pixels wide)
  world_y = half - pixel_size * y

  canvas_pixels.times do |x|
    print '.'

    world_x = -half + pixel_size * x
    position = Point.new(world_x, world_y, wall_z)
    ray = Ray.new(ray_origin, (position - ray_origin).normalize)
    hit = ray.hit(sphere)

    if hit
      point = ray.position(hit.t)
      normal = hit.object.normal_at(point)
      eye = -ray.direction
      color = Lighting.light(material: hit.object.material, light: light, position: point, eyev: eye, normalv: normal)

      canvas.write(x, y, color)
    end
  end
end

puts
puts "Took #{Time.now - start_time} seconds"

path = canvas.to_ppm(File.join(File.expand_path(File.dirname(__FILE__)), 'chapter6'))
`open #{path}`
