require_relative './color'

class Canvas

  attr_reader :pixels

  def initialize(width, height)
    @pixels = Array.new(height) { Array.new(width, Color.new(0, 0, 0)) }
  end

  def [](*args)
    pixels[*args]
  end

  def width
    pixels[0].size
  end

  def height
    pixels.size
  end

  def write(x, y, color)
    pixels[y][x] = color
  end

  def fill(color)
    pixels.each do |row|
      row.fill(color)
    end
  end

  def read(x, y)
    pixels[y][x]
  end

end
