require_relative '../../tuple'
require_relative './projectile'
require_relative './environment'

def tick(environment, projectile)
  position = projectile.position + projectile.velocity
  velocity = projectile.velocity + environment.gravity + environment.wind
  Projectile.new(position, velocity)
end

projectile = Projectile.new(Tuple.new(0, 1, 0, :point), Tuple.new(1, 1, 0, :vector).normalize)
environment = Environment.new(Tuple.new(0, -0.1, 0, :vector), Tuple.new(-0.01, 0, 0, :vector))
count = 0

while(projectile.position.y > 0) do
  projectile = tick(environment, projectile)
  count += 1
  puts "#{count}: #{projectile.position.to_a.inspect}"
end
