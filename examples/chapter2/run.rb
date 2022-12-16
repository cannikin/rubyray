require_relative '../../lib/point'
require_relative '../../lib/vector'
require_relative '../../lib/canvas'
require_relative '../../lib/ppm'

class Projectile
  attr_reader :position, :velocity

  def initialize(position, velocity)
    @position = position
    @velocity = velocity
  end
end

class Environment
  attr_reader :gravity, :wind

  def initialize(gravity, wind)
    @gravity = gravity
    @wind = wind
  end
end

def tick(environment, projectile)
  position = projectile.position + projectile.velocity
  velocity = projectile.velocity + environment.gravity + environment.wind
  Projectile.new(position, velocity)
end

start = Point.new(0, 1, 0)
velocity = Vector.new(1, 1, 0).normalize * 11.25
gravity = Vector.new(0, -0.1, 0)
wind = Vector.new(-0.02, 0, 0)
projectile = Projectile.new(start, velocity)
environment = Environment.new(gravity, wind)
red = Color.new(1, 0, 0)
canvas = Canvas.new(1100, 350)

while (projectile.position.y > 0 and projectile.position.y < canvas.height and projectile.position.x < canvas.width) do
  canvas.write(projectile.position.x.round, canvas.height - projectile.position.y.round, red)
  projectile = tick(environment, projectile)
  print '.'
end

ppm = PPM.new(canvas)
filename = File.join(File.expand_path(File.dirname(__FILE__)), 'chapter2.ppm')
puts "\nWriting #{filename}..."
File.open(filename, 'w') do |f|
  f.puts ppm.to_s
end
`open #{filename}`
