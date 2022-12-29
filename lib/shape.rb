require_relative './point'
require_relative './matrix'
require_relative './material'

class Shape

  @@id = 0

  attr_reader :id, :origin
  attr_accessor :material, :transform

  def initialize
    @@id += 1
    @id = @@id
    @origin = Point.new(0, 0, 0)
    @transform = Matrix.identity
    @material = Material.new
  end

end
