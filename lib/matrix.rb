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

  def self.translate(x, y, z)
    self.new([
      [1, 0, 0, x],
      [0, 1, 0, y],
      [0, 0, 1, z],
      [0, 0, 0, 1]
    ])
  end

  def self.scale(x, y, z)
    self.new([
      [x, 0, 0, 0],
      [0, y, 0, 0],
      [0, 0, z, 0],
      [0, 0, 0, 1]
    ])
  end

  def self.rotate_x(rad)
    self.new([
      [1, 0,             0,              0],
      [0, Math.cos(rad), -Math.sin(rad), 0],
      [0, Math.sin(rad), Math.cos(rad),  0],
      [0, 0,             0,              1]
    ])
  end

  def self.rotate_y(rad)
    self.new([
      [Math.cos(rad),  0, Math.sin(rad),  0],
      [0,              1, 0,              0],
      [-Math.sin(rad), 0, Math.cos(rad),  0],
      [0,              0, 0,              1]
    ])
  end

  def self.rotate_z(rad)
    self.new([
      [Math.cos(rad), -Math.sin(rad), 0, 0],
      [Math.sin(rad), Math.cos(rad),  0, 0],
      [0,             0,              1, 0],
      [0,             0,              0, 1]
    ])
  end

  def self.shear(xy, xz, yx, yz, zx, zy)
    self.new([
      [1,  xy, xz, 0],
      [yx, 1,  yz, 0],
      [zx, zy, 1,  0],
      [0,  0,  0,  1]
    ])
  end

  def translate(*args)
    self.class.translate(*args) * self
  end

  def scale(*args)
    self.class.scale(*args) * self
  end

  def rotate_x(*args)
    self.class.rotate_x(*args) * self
  end

  def rotate_y(*args)
    self.class.rotate_y(*args) * self
  end

  def rotate_z(*args)
    self.class.rotate_z(*args) * self
  end

  def shear(*args)
    self.class.shear(*args) * self
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
    self.class.new(rows.clone.map(&:clone))
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
        inverted[col][row] = co / determinant
      end
    end

    return inverted
  end

  # not used because we trust that the delta check in == considers float
  # rounding errors to be == 0
  private def round_to_zero(&block)
    output = yield

    # check for zero
    if output.abs < Tuple::EPSILON
      return 0
    else
      return output
    end
  end

  private def matrix_product(other)
    product = self.class.new(Array.new(size) { [] })

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

    Tuple.new(*members).to_concrete_type
  end

end
