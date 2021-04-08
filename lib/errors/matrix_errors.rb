class Matrix

  class InvalidStructureError < StandardError

    def initialize
      super("Rows and column counts must match")
    end

  end

end
