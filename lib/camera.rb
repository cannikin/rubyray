require 'parallel'

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

  def render(world, opts = {})
    options = { progress: false, processes: 1 }.merge(opts)
    start_time = Time.now

    chunks = row_blocks(options[:processes]).collect do |range|
      { range:, camera: self, world:, debug: options[:progress] }
    end

    if options[:progress]
      puts "Rendering in #{options[:processes]} processes, #{chunks.collect { |c| c[:range] }.inspect}, started at #{Time.now}"
    end

    # render chunks in parallel
    row_blocks = Parallel.map(chunks, in_processes: options[:processes]) do |chunk|
      render_chunk(chunk)
    end

    # reassemble chunks back into a canvas
    canvas = Canvas.new(hsize, vsize)
    row_blocks.each do |block|
      canvas.write_range(block[:range], block[:colors])
    end

    if options[:progress]
      puts "\nRendered #{hsize * vsize} pixels in #{Time.now - start_time} seconds"
    end

    return canvas
  end

  # given the number of vertical pixels the camera has, split that up into
  # `count` chunks of equal size (last block might be larger)
  def row_blocks(count)
    blocks = []
    block_size = vsize / count

    start_row = 0
    count.times do |i|
      end_row = start_row + block_size - 1
      blocks << (start_row..end_row)
      start_row = end_row + 1
    end

    # if we have rows left over after splitting up chunks, give them to the last
    # process to compute
    last_range = blocks.last
    if last_range.max < vsize
      extra_rows = vsize - (last_range.max + 1)
      blocks[blocks.size-1] = last_range.min..(last_range.max + extra_rows)
    end

    return blocks
  end

  private def render_chunk(chunk)
    colors = []

    chunk[:range].min.upto(chunk[:range].max) do |y|
      colors[y] = []
      chunk[:camera].hsize.times do |x|
        print '.' if chunk[:debug]
        ray = chunk[:camera].ray_for_pixel(x, y)
        color = chunk[:world].color_at(ray)
        colors[y][x] = color
      end
    end

    return { range: chunk[:range], colors: colors.compact }
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
