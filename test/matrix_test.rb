require_relative './test_helper'
require_relative '../lib/matrix'

class MatrixTest < Minitest::Test

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

    assert_equal -3, matrix[0][0]
    assert_equal  5, matrix[0][1]
    assert_equal  1, matrix[1][0]
    assert_equal -2, matrix[1][1]
  end

  test '#initialize a 3x3 matrix' do
    matrix = Matrix.new([
      [ -3,  5,  0],
      [  1, -2, -7],
      [  0,  1,  1]
    ])

    assert_equal -3, matrix[0][0]
    assert_equal -2, matrix[1][1]
    assert_equal  1, matrix[2][2]
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

end
