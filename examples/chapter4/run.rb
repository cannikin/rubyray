require_relative "../../lib/point"
require_relative "../../lib/matrix"
require_relative "../../lib/canvas"
require_relative "../../lib/ppm"

canvas = Canvas.new(500, 500)
size = canvas.width / 3
red = Color.new(1, 0, 0)

point = Point.new(0, 1, 0)
rotation = Matrix.rotate_z(-Math::PI / 6)

1.upto(12) do
  canvas.write((point.x * size) + (canvas.width / 2), (point.y * size) + (canvas.height / 2), red)
  point = rotation * point
end

canvas.to_ppm(File.join(__dir__, "chapter4"))
