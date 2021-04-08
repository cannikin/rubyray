require_relative './errors/matrix_errors'

class Matrix

  attr_reader :rows

  def initialize(rows)
    @rows = rows
    validate!
  end

  def [](index)
    rows[index]
  end

  def ==(other)
    rows == other.rows
  end

  private def validate!
    row_count = rows.size
    rows.each do |row|
      raise InvalidStructureError if row.size != row_count
    end
  end

end
