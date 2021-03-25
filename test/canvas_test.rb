require_relative './test_helper'
require_relative '../lib/canvas'

class CanvasTest < Minitest::Test

  test '#initialize width and height' do
    canvas = Canvas.new(10, 20)

    assert_equal 10, canvas.width
    assert_equal 20, canvas.height
  end

  test '#initialize every pixel as black' do
    canvas = Canvas.new(10, 20)

    canvas.width.times do |i|
      canvas.height.times do |j|
        assert_equal Color.new(0, 0, 0), canvas.read(i, j)
      end
    end
  end

  test '#read reads a pixel color' do
    canvas = Canvas.new(10, 10)
    red = Color.new(1, 0, 0)
    canvas.write(2, 3, red)

    assert_equal red, canvas.read(2, 3)
  end

  test '#write sets a pixel color' do
    canvas = Canvas.new(10, 10)
    red = Color.new(1, 0, 0)
    black = Color.new(0, 0, 0)
    canvas.write(2, 3, red)

    assert_equal red, canvas.read(2, 3)
    assert_equal black, canvas.read(3, 2)
    assert_equal black, canvas.read(2, 2)
    assert_equal black, canvas.read(3, 3)
  end

  test '#fill sets all pixels to the given color' do
    canvas = Canvas.new(2, 2)
    red = Color.new(1, 0, 0)
    canvas.fill(red)

    assert_equal red, canvas.read(0, 0)
    assert_equal red, canvas.read(0, 1)
    assert_equal red, canvas.read(1, 0)
    assert_equal red, canvas.read(1, 1)
  end
end
