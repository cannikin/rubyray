require_relative "tuple"

class Color < Tuple
  alias_method :red, :x
  alias_method :green, :y
  alias_method :blue, :z

  def self.white
    new(1, 1, 1)
  end

  def self.black
    new(0, 0, 0)
  end

  def +(*args)
    tuple = super
    Color.new(*tuple)
  end

  def -(*args)
    tuple = super
    Color.new(*tuple)
  end

  def *(other)
    if other.is_a? Color
      Color.new(red * other.red, green * other.green, blue * other.blue)
    else
      tuple = super
      Color.new(*tuple)
    end
  end

  def to_s(min, max)
    [red, green, blue].map { |color| (color * max).round.clamp(min, max) }.join(" ")
  end
end
