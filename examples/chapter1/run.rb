require_relative '../../point'
require_relative '../../vector'

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

projectile = Projectile.new(Point.new(0, 1, 0), Vector.new(1, 1, 0).normalize)
environment = Environment.new(Vector.new(0, -0.1, 0), Vector.new(-0.01, 0, 0))
count = 0

while(projectile.position.y > 0) do
  projectile = tick(environment, projectile)
  count += 1
  puts "#{count}: #{projectile.position.to_a.inspect}"
end
