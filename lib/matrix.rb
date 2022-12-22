require_relative 'errors/matrix_errors'
require_relative 'tuple'

class Matrix

  attr_reader :rows

  def self.identity(size = 4)
    base = []
    size.times do |count|
      row = Array.new(size, 0)
      row[count] = 1
      base.push(row)
    end

    self.new(base)
  end

  def initialize(rows)
    @rows = rows
  end

  # format matrixes nicer than default Array#inspect output
  #
  # ┌─     ─┐
  # │ 3, -1 │
  # │ 2,  6 │
  # └─     ─┘

  def to_s
    # figure out longest number
    largest = 1
    rows.each do |row|
      row.each do |col|
        length = col.round(5).to_s.length
        length += 1 if col < 0
        largest = length if length > largest
      end
    end

    # actually format output
    output = []
    gap = ((largest + 1) * size - 2)
    gap += 1 if largest == 1
    output.push("┌─#{' ' * gap}─┐")
    rows.each do |row|
      line = '│'
      line += ' ' if largest == 1
      row.each do |col|
        line += "#{col.round(5).to_s.rjust(largest)} "
      end
      line += '│'
      output.push(line)
    end
    output.push("└─#{' ' * gap}─┘")

    return output.join("\n")
  end

  def [](index)
    rows[index]
  end

  def ==(other)
    same = true

    size.times do |row|
      break if !same
      size.times do |col|
        break if !same
        same = (rows[row][col] - other.rows[row][col]).abs <= Tuple::EPSILON
      end
    end

    return same
  end

  def *(other)
    case other
    when Matrix
      matrix_product(other)
    when Tuple
      tuple_product(other)
    end
  end

  def transpose
    self.class.new(rows.transpose)
  end

  def size
    rows.size
  end

  def determinant
    det = 0

    if size == 2
      det = rows[0][0] * rows[1][1] - rows[0][1] * rows[1][0]
    else
      size.times do |col|
        det += rows[0][col] * cofactor(0, col)
      end
    end

    return det
  end

  def clone
    Matrix.new(rows.clone.map(&:clone))
  end

  def sub(row, col)
    submatrix = clone

    submatrix.rows.delete_at(row)
    submatrix.rows.each do |row|
      row.delete_at(col)
    end

    return submatrix
  end

  def minor(row, col)
    sub(row, col).determinant
  end

  def cofactor(row, col)
    minor = minor(row, col)

    (row + col).odd? ? -minor.to_f : minor.to_f
  end

  def invertable?
    determinant != 0
  end

  def inverse
    raise NotInvertableError if !invertable?

    inverted = clone

    size.times do |row|
      size.times do |col|
        co = cofactor(row, col).to_f
        inverted[col][row] = (co / determinant)
      end
    end

    return inverted
  end

  private def matrix_product(other)
    product = Matrix.new(Array.new(size) { [] })

    size.times do |row|
      size.times do |col|
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

    size.times do |row|
      members[row] = rows[row][0] * tuple.x +
                     rows[row][1] * tuple.y +
                     rows[row][2] * tuple.z +
                     rows[row][3] * tuple.w
    end

    Tuple.new(*members)
  end

end
