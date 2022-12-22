require_relative './test_helper'
require_relative '../lib/matrix'
require_relative '../lib/tuple'

class MatrixTest < Minitest::Test

  test '.identity returns an identity matrix' do
    assert_equal Matrix.new([
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1],
    ]), Matrix.identity(3)

    # defaults to 4x4
    assert_equal Matrix.new([
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1]
    ]), Matrix.identity
  end

  test '#initialize a 4x4 matrix' do
    matrix = Matrix.new([
      [   1,    2,    3,    4],
      [5.5 ,6.5  ,7.5  ,  8.5],
      [   9,   10,   11,   12],
      [13.5, 14.5, 15.5, 16.5]
    ])

    assert_equal 1,    matrix[0][0]
    assert_equal 4,    matrix[0][3]
    assert_equal 5.5,  matrix[1][0]
    assert_equal 7.5,  matrix[1][2]
    assert_equal 11,   matrix[2][2]
    assert_equal 13.5, matrix[3][0]
    assert_equal 15.5, matrix[3][2]
  end

  test '#initialize a 2x2 matrix' do
    matrix = Matrix.new([
      [ -3,  5],
      [  1, -2]
    ])

    assert_equal(-3, matrix[0][0])
    assert_equal(5, matrix[0][1])
    assert_equal(1, matrix[1][0])
    assert_equal(-2, matrix[1][1])
  end

  test '#initialize a 3x3 matrix' do
    matrix = Matrix.new([
      [ -3,  5,  0],
      [  1, -2, -7],
      [  0,  1,  1]
    ])

    assert_equal(-3, matrix[0][0])
    assert_equal(-2, matrix[1][1])
    assert_equal(1, matrix[2][2])
  end

  test '#== compares two equal matrixes' do
    matrixA = Matrix.new([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2]
    ])
    matrixB = Matrix.new([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2]
    ])

    assert matrixA == matrixB
  end

  test '#== compares two unequal matrixes' do
    matrixA = Matrix.new([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2]
    ])
    matrixB = Matrix.new([
      [2, 3, 4, 5],
      [6, 7, 8, 9],
      [8, 7, 6, 5],
      [4, 3, 2, 1]
    ])

    assert matrixA != matrixB
  end

  test '#* multipling two matrixes' do
    matrixA = Matrix.new([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2]
    ])
    matrixB = Matrix.new([
      [-2, 1, 2,  3],
      [ 3, 2, 1, -1],
      [ 4, 3, 6,  5],
      [ 1, 2, 7,  8]
    ])
    product = matrixA * matrixB

    assert_equal Matrix.new([
      [20, 22,  50,  48],
      [44, 54, 114, 108],
      [40, 58, 110, 102],
      [16, 26,  46,  42]
    ]), product
  end

  test '#* multipling a matrix and a tuple' do
    matrix = Matrix.new([
      [1, 2, 3, 4],
      [2, 4, 4, 2],
      [8, 6, 4, 1],
      [0, 0, 0, 1]
    ])
    tuple = Tuple.new(1, 2, 3, 1)
    product = matrix * tuple

    assert_equal Tuple.new(18, 24, 33, 1), product
  end

  test '#* multipling a matrix by an identity matrix returns the same matrix' do
    matrix = Matrix.new([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2]
    ])
    product = matrix * Matrix.identity

    assert_equal matrix, product
  end

  test '#* multipling the identity matrix by a tuple returns the tuple' do
    tuple = Tuple.new(1, 2, 3, 4)
    product = Matrix.identity * tuple

    assert_equal tuple, product
  end

  test '#transpose swaps rows and columns' do
    original = Matrix.new([
      [0, 9, 3, 0],
      [9, 8, 0, 8],
      [1, 8, 5, 3],
      [0, 0, 5, 8]
    ])
    transposed = Matrix.new([
      [0, 9, 1, 0],
      [9, 8, 8, 0],
      [3, 0, 5, 5],
      [0, 8, 3, 8]
    ])

    assert_equal transposed, original.transpose
  end

  test '#transpose with the identity matrix is still the identity matrix' do
    assert_equal Matrix.identity.transpose, Matrix.identity
  end

  test '#determinant of a 2x2 matrix' do
    matrix = Matrix.new([
      [1, 5],
      [-3, 2]
    ])

    assert_equal 17, matrix.determinant
  end

  test '#determinant of a 3x3 matrix' do
    matrix = Matrix.new([
      [1, 2, 6],
      [-5, 8, -4],
      [2, 6, 4]
    ])

    assert_equal 56,   matrix.cofactor(0, 0)
    assert_equal 12,   matrix.cofactor(0, 1)
    assert_equal(-46,  matrix.cofactor(0, 2))
    assert_equal(-196, matrix.determinant)
  end

  test '#determinant of a 4x4 matrix' do
    matrix = Matrix.new([
      [-2, -8, 3, 5],
      [-3, 1, 7, 3],
      [1, 2, -9, 6],
      [-6, 7, 7, -9]
    ])

    assert_equal 690,   matrix.cofactor(0, 0)
    assert_equal 447,   matrix.cofactor(0, 1)
    assert_equal 210,   matrix.cofactor(0, 2)
    assert_equal 51,    matrix.cofactor(0, 3)
    assert_equal(-4071, matrix.determinant)

  end

  test '#sub returns ths submatrix of a 3x3 matrix' do
    matrix = Matrix.new([
      [1, 5, 0],
      [-3, 2, 7],
      [0, 6, -3]
    ])

    submatrix = Matrix.new([
      [-3, 2],
      [0, 6]
    ])

    assert_equal submatrix, matrix.sub(0, 2)
  end

  test '#sub returns ths submatrix of a 4x4 matrix' do
    matrix = Matrix.new([
      [-6, 1, 1, 6],
      [-8, 5, 8, 6],
      [-1, 0, 0, 2],
      [-7, 1, -1, 1]
    ])

    submatrix = Matrix.new([
      [-6, 1, 6],
      [-8, 8, 6],
      [-7, -1, 1]
    ])

    assert_equal submatrix, matrix.sub(2, 1)
  end

  test '#minor of a 3x3 matrix' do
    matrix = Matrix.new([
      [3, 5, 0],
      [2, -1, -7],
      [6, -1, 5],
    ])
    submatrix = matrix.sub(1, 0)

    assert_equal 25, submatrix.determinant
    assert_equal 25, matrix.minor(1, 0)
  end

  test '#cofactor of a 3x3 matrix' do
    matrix = Matrix.new([
      [3, 5, 0],
      [2, -1, -7],
      [6, -1, 5],
    ])

    assert_equal(-12, matrix.minor(0, 0))
    assert_equal(-12, matrix.cofactor(0, 0))
    assert_equal 25, matrix.minor(1, 0)
    assert_equal(-25, matrix.cofactor(1, 0))
  end

  test '#invertable? tests for ability to invert' do
    matrix = Matrix.new([
      [6, 4, 4, 4],
      [5, 5, 7, 6],
      [4, -9, 3, -7],
      [9, 1, 7, -6]
    ])

    assert_equal(-2120, matrix.determinant)
    assert matrix.invertable?

    matrix = Matrix.new([
      [-4, 2, -2, -3],
      [9, 6, 2, 6],
      [0, -5, 1, -5],
      [0, 0, 0, 0]
    ])

    assert_equal 0, matrix.determinant
    assert !matrix.invertable?
  end

  test '#inverse of a matrix' do
    matrix = Matrix.new([
      [-5, 2, 6, -8],
      [1, -5, 1, 8],
      [7, 7, -6, -7],
      [1, -3, 7, 4]
    ])
    inverse = matrix.inverse

    assert_equal 532, matrix.determinant
    assert_equal(-160, matrix.cofactor(2, 3))
    assert_in_delta (-160.0 / 532.0), inverse[3][2], Tuple::EPSILON
    assert_equal 105, matrix.cofactor(3, 2)
    assert_in_delta (105.0 / 532.0), inverse[2][3], Tuple::EPSILON
    assert_equal(Matrix.new([
      [0.21805,   0.45113,  0.24060, -0.04511],
      [-0.80827, -1.45677, -0.44361,  0.52068],
      [-0.07895, -0.22368, -0.05263,  0.19737],
      [-0.52256, -0.81391, -0.30075,  0.30639]
    ]), inverse)

    # another test to be sure
    matrix = Matrix.new([
      [8, -5, 9, 2],
      [7, 5, 6, 1],
      [-6, 0, 9, 6],
      [-3, 0, -9, -4]
    ])

    inverse = Matrix.new([
      [-0.15385, -0.15385, -0.28205, -0.53846],
      [-0.07692, 0.12308, 0.02564, 0.03077],
      [0.35897, 0.35897, 0.4359, 0.92308],
      [-0.69231, -0.69231, -0.76923, -1.92308]
    ])

    assert_equal inverse, matrix.inverse

    # another test
    matrix = Matrix.new([
      [9, 3, 0, 9],
      [-5, -2, -6, -3],
      [-4, 9, 6, 4],
      [-7, 6, 6, 2]
    ])

    inverse = Matrix.new([
      [-0.04074, -0.07778, 0.14444, -0.22222],
      [-0.07778, 0.03333, 0.36667, -0.33333],
      [-0.02901, -0.1463, -0.10926, 0.12963],
      [0.17778, 0.06667, -0.26667, 0.33333]
    ])

    assert_equal inverse, matrix.inverse
  end

  test 'a multiplied matrix can be unmultiplied by the inverse' do
    matrixA = Matrix.new([
      [3, -9, 7, 3],
      [3, -8, 2, -9],
      [-4, 4, 4, 1],
      [-6, 5, -1, 1]
    ])
    matrixB = Matrix.new([
      [8, 2, 2, 2],
      [3, -1, 7, 0],
      [7, 0, 5, 4],
      [6, -2, 0, 5]
    ])
    matrixC = matrixA * matrixB

    assert_equal matrixA, matrixC * matrixB.inverse
  end

end
