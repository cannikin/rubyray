require_relative './tuple'

class Color < Tuple

  alias :red :x
  alias :green :y
  alias :blue :z

  def +(*args)
    tuple = super
    Color.new(*tuple)
  end

  def -(*args)
    tuple = super
    Color.new(*tuple)
  end

  def *(other)
    if other.kind_of? Color
      Color.new(self.red * other.red, self.green * other.green, self.blue * other.blue)
    else
      tuple = super
      Color.new(*tuple)
    end
  end

  def to_s(min, max)
    [red, green, blue].map { |color| (color * max).round.clamp(min, max) }.join(' ')
  end

end
