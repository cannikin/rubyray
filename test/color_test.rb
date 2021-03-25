require_relative './test_helper'
require_relative '../color'

class ColorTest < Minitest::Test

  test 'aliases x, y and z to red, green and blue' do
    color = Color.new(-0.5, 0.4, 1.7)

    assert_equal color.red, -0.5
    assert_equal color.green, 0.4
    assert_equal color.blue, 1.7
  end

end
