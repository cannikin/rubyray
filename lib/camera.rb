class Camera

  attr_reader :hsize, :vsize, :field_of_view, :aspect_ratio
  attr_accessor :transform

  def initialize(hsize, vsize, field_of_view)
    @hsize = hsize
    @vsize = vsize
    @field_of_view = field_of_view
    @transform = Matrix.identity
    @half_view = Math.tan(field_of_view / 2)
    @aspect_ratio = hsize.to_f / vsize.to_f
  end

  def pixel_size
    @pixel_size ||= (half_width * 2) / hsize
  end

  def ray_for_pixel(x, y)
    xoffset = (x + 0.5) * pixel_size
    yoffset = (y + 0.5) * pixel_size

    world_x = half_width - xoffset
    world_y = half_height - yoffset

    inverse = transform.inverse
    pixel = inverse * Point.new(world_x, world_y, -1)
    origin = inverse * Point.origin
    direction = (pixel - origin).normalize

    return Ray.new(origin, direction)
  end

  def render(world, options = { progress: false })
    image = Canvas.new(hsize, vsize)
    start_time = Time.now

    vsize.times do |y|
      hsize.times do |x|
        print '.' if options[:progress]
        ray = ray_for_pixel(x, y)
        color = world.color_at(ray)
        image.write(x, y, color)
      end
    end

    if options[:progress]
      puts "Rendered #{hsize * vsize} pixels in #{Time.now - start_time} seconds"
    end

    return image
  end

  private def half_height
    @half_height ||= begin
      if aspect_ratio >= 1
        @half_view / aspect_ratio
      else
        @half_view
      end
    end
  end

  private def half_width
    @half_width ||= begin
      if aspect_ratio >= 1
        @half_view
      else
        @half_view * aspect_ratio
      end
    end
  end

end
