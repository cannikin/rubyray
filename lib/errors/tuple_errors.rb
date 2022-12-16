class Tuple

  class UnknownTupleError < StandardError

    def initialize(w)
      super("Unknown W value #{w}")
    end

  end

end
