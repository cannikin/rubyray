require_relative 'errors/matrix_errors'
require_relative 'tuple'

class Matrix

  attr_reader :rows

  def self.identity
    self.new([
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1]
    ])
  end

  def initialize(rows)
    @rows = rows
  end

  def [](index)
    rows[index]
  end

  def ==(other)
    rows == other.rows
  end

  def *(other)
    case other
    when Matrix
      matrix_product(other)
    when Tuple
      tuple_product(other)
    end
  end

  def size
    rows.size
  end

  private def matrix_product(other)
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

  private def tuple_product(tuple)
    members = Array.new(4)

    rows.size.times do |row|
      members[row] = rows[row][0] * tuple.x +
                     rows[row][1] * tuple.y +
                     rows[row][2] * tuple.z +
                     rows[row][3] * tuple.w
    end

    Tuple.new(*members)
  end

end
