class Canvas

  class OutOfBoundsError < StandardError

    def initialize(x=0, y=0)
      super("#{x}, #{y} is outside the bounds of the canvas")
    end

  end

end
