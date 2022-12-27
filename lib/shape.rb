require_relative './point'
require_relative './matrix'

class Shape

  @@id = 0

  attr_reader :id, :origin
  attr_accessor :transform

  def initialize
    @@id += 1
    @id = @@id
    @origin = Point.new(0, 0, 0)
    @transform = Matrix.identity
  end

end
