require_relative './test_helper'
require_relative '../lib/point_light'

require_relative '../lib/color'
require_relative '../lib/point'

class PointLightTest < Minitest::Test

  test 'a point light has a position and intensity' do
    intensity = Color.new(1, 1, 1)
    position = Point.new(0, 0, 0)
    light = PointLight.new(position, intensity)

    assert_equal position, light.position
    assert_equal intensity, light.intensity
  end

end
