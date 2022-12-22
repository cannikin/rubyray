class Tuple

  class UnknownTupleError < StandardError

    def initialize(w)
      super("Unknown W value #{w}")
    end

  end

  class NotPointError < StandardError

    def initialize(w)
      super("Tuple with w #{w} is not a point")
    end

  end

  class NotVectorError < StandardError

    def initialize(w)
      super("Tuple with w #{w} is not a vector")
    end

  end

end
