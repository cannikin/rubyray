require_relative './test_helper'
require_relative '../lib/color'

class ColorTest < Minitest::Test

  test 'aliases x, y and z to red, green and blue' do
    color = Color.new(-0.5, 0.4, 1.7)

    assert_equal color.red, -0.5
    assert_equal color.green, 0.4
    assert_equal color.blue, 1.7
  end

  test 'adding colors' do
    color1 = Color.new(0.9, 0.6, 0.75)
    color2 = Color.new(0.7, 0.1, 0.25)
    result = color1 + color2

    assert_instance_of Color, result
    assert_equal result, Color.new(1.6, 0.7, 1.0)
  end

  test 'subtracing colors' do
    color1 = Color.new(0.9, 0.6, 0.75)
    color2 = Color.new(0.7, 0.1, 0.25)
    result = color1 - color2

    assert_instance_of Color, result
    assert_in_epsilon result.red, 0.2
    assert_in_epsilon result.green, 0.5
    assert_in_epsilon result.blue, 0.5
  end

  test 'multiplying color by scalar' do
    color = Color.new(0.2, 0.3, 0.4)
    result = color * 2

    assert_instance_of Color, result
    assert_equal result, Color.new(0.4, 0.6, 0.8)
  end

  test 'multiplying color by color' do
    color1 = Color.new(1, 0.2, 0.4)
    color2 = Color.new(0.9, 1, 0.1)
    result = color1 * color2

    assert_instance_of Color, result
    assert_in_epsilon result.red, 0.9
    assert_in_epsilon result.green, 0.2
    assert_in_epsilon result.blue, 0.04
  end

end
