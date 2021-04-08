require_relative './errors/matrix_errors'

class Matrix

  attr_reader :rows

  def initialize(rows)
    @rows = rows
    # validate!
  end

  def [](index)
    rows[index]
  end

  def ==(other)
    rows == other.rows
  end

  def *(other)
    product = Matrix.new(Array.new(size) { [] })

    rows.size.times do |row|
      rows.size.times do |col|
        product[row][col] = rows[row][0] * other.rows[0][col] +
                            rows[row][1] * other.rows[1][col] +
                            rows[row][2] * other.rows[2][col] +
                            rows[row][3] * other.rows[3][col]
      end
    end

    product
  end

  def size
    rows.size
  end

  private def validate!
    row_count = rows.size
    rows.each do |row|
      raise InvalidStructureError if row.size != row_count
    end
  end

end
