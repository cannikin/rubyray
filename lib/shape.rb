require_relative './point'

class Shape

  @@id = 0

  attr_reader :id, :origin

  def initialize
    @@id += 1
    @id = @@id
    @origin = Point.new(0, 0, 0)
  end

end
