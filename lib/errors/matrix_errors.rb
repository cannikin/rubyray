class Matrix

  # class InvalidStructureError < StandardError

  #   def initialize
  #     super("Rows and column counts must match")
  #   end

  # end

  class NotInvertableError < StandardError

    def initialize
      super("Matrix is not invertable")
    end

  end
end
