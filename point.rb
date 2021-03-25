require_relative './tuple'

class Point < Tuple

    def initialize(*args)
      super
      @list << 1.0
    end

end
