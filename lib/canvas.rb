require_relative './color'
require_relative './ppm'

class Canvas

  class OutOfBoundsError < StandardError; end

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
    raise OutOfBoundsError if x < 0 or y < 0 or x > width or y > height
    pixels[y][x] = color
  end

  def write_range(range, colors)
    range.each_with_index do |y, i|
      pixels[y] = colors[i]
    end
  end

  def fill(color)
    pixels.each do |row|
      row.fill(color)
    end
  end

  def read(x, y)
    pixels[y][x]
  end

  def to_ppm(filename)
    ppm = PPM.new(self)
    path = "#{filename}.ppm"
    puts "\nWriting #{path}..."
    File.open(path, 'w') do |f|
      f.puts ppm.to_s
    end
    return path
  end

end
