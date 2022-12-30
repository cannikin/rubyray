require_relative 'test_helper'

class PointLightTest < Minitest::Test

  test 'a point light has a position and intensity' do
    intensity = Color.new(1, 1, 1)
    position = Point.new(0, 0, 0)
    light = PointLight.new(position, intensity)

    assert_equal position, light.position
    assert_equal intensity, light.intensity
  end

end
