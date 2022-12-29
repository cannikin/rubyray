require_relative './light'

class PointLight < Light

  attr_reader :position, :intensity

  def initialize(position, intensity)
    @position = position
    @intensity = intensity
  end

end
