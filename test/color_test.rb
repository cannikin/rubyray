require_relative './test_helper'
require_relative '../lib/color'

class ColorTest < Minitest::Test

  test '.white returns pure white' do
    assert_equal Color.new(1, 1, 1), Color.white
  end

  test '.black returns pure black' do
    assert_equal Color.new(0, 0, 0), Color.black
  end

  test 'aliases x, y and z to red, green and blue' do
    color = Color.new(-0.5, 0.4, 1.7)

    assert_equal(-0.5, color.red)
    assert_equal  0.4, color.green
    assert_equal  1.7, color.blue
  end

  test 'adding colors' do
    color1 = Color.new(0.9, 0.6, 0.75)
    color2 = Color.new(0.7, 0.1, 0.25)
    result = color1 + color2

    assert_instance_of Color, result
    assert_equal Color.new(1.6, 0.7, 1.0), result
  end

  test 'subtracing colors' do
    color1 = Color.new(0.9, 0.6, 0.75)
    color2 = Color.new(0.7, 0.1, 0.25)
    result = color1 - color2

    assert_instance_of Color, result
    assert_in_epsilon 0.2, result.red
    assert_in_epsilon 0.5, result.green
    assert_in_epsilon 0.5, result.blue
  end

  test 'multiplying color by scalar' do
    color = Color.new(0.2, 0.3, 0.4)
    result = color * 2

    assert_instance_of Color, result
    assert_equal Color.new(0.4, 0.6, 0.8), result
  end

  test 'multiplying color by color' do
    color1 = Color.new(1, 0.2, 0.4)
    color2 = Color.new(0.9, 1, 0.1)
    result = color1 * color2

    assert_instance_of Color, result
    assert_in_epsilon 0.9, result.red
    assert_in_epsilon 0.2, result.green
    assert_in_epsilon 0.04, result.blue
  end

  test '#to_s returns the color ready for output in a PPM' do
    color = Color.new(1.5, 0.5, -1.0)
    result = color.to_s(0, 255)

    assert_equal '255 128 0', result
  end
end
