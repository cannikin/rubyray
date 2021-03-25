class PPM

  IDENTIFIER = 'P3'
  MAX_COLOR_VALUE = 255
  MIN_COLOR_VALUE = 0
  MAX_LINE_LENGTH = 70

  attr_reader :canvas

  def initialize(canvas)
    @canvas = canvas
  end

  def to_s
    [header, wrap(body), "\n"].join("\n")
  end

  def write(filename)
    header
  end

  private def header
    [IDENTIFIER, "#{canvas.width} #{canvas.height}", MAX_COLOR_VALUE].join("\n")
  end

  private def body
    canvas.pixels.collect do |row|
      line = row.collect do |col|
        col.to_s(MIN_COLOR_VALUE, MAX_COLOR_VALUE)
      end.join(' ')
    end.join("\n")
  end

  # wraps lines on spaces only to MAX_LINE_LENGTH
  private def wrap(text)
    text.split("\n").collect! do |line|
      line.length > MAX_LINE_LENGTH ? line.gsub(/(.{1,#{MAX_LINE_LENGTH}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end

end
