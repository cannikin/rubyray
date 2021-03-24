class Environment

  attr_reader :gravity, :wind

  def initialize(gravity, wind)
    @gravity = gravity
    @wind = wind
  end

end
