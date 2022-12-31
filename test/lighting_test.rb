require_relative 'test_helper'
require_relative '../lib/lighting'

require_relative '../lib/point'
require_relative '../lib/vector'
require_relative '../lib/material'

class LightingTest < Minitest::Test

  def setup
    @point = Point.origin
    @material = Material.new
  end

  test 'lighting with the eye between the light and the surface' do
    eyev = Vector.new(0, 0, -1)
    normalv = Vector.new(0, 0, -1)
    light = PointLight.new(Point.new(0, 0, -10), Color.white)
    result = Lighting.light(material: @material, light:, point: @point, eyev:, normalv:)

    assert_equal Color.new(1.9, 1.9, 1.9), result
  end

  test' lighting with the eye between light and surface, eye offset 45°' do
    eyev = Vector.new(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2)
    normalv = Vector.new(0, 0, -1)
    light = PointLight.new(Point.new(0, 0, -10), Color.white)
    result = Lighting.light(material: @material, light:, point: @point, eyev:, normalv:)

    assert_equal Color.white, result
  end

  test 'lighting with eye opposite surface, light offset 45°' do
    eyev = Vector.new(0, 0, -1)
    normalv = Vector.new(0, 0, -1)
    light = PointLight.new(Point.new(0, 10, -10), Color.white)
    result = Lighting.light(material: @material, light:, point: @point, eyev:, normalv:)

    assert_equal Color.new(0.7364, 0.7364, 0.7364), result
  end

  test 'lighting with eye in the path of the reflection vector' do
    eyev = Vector.new(0, -Math.sqrt(2) / 2, -Math.sqrt(2) / 2)
    normalv = Vector.new(0, 0, -1)
    light = PointLight.new(Point.new(0, 10, -10), Color.white)
    result = Lighting.light(material: @material, light:, point: @point, eyev:, normalv:)

    assert_equal Color.new(1.6364, 1.6364, 1.6364), result
  end

  test 'lighting with the light behind the surface' do
    eyev = Vector.new(0, 0, -1)
    normalv = Vector.new(0, 0, -1)
    light = PointLight.new(Point.new(0, 0, 10), Color.white)
    result = Lighting.light(material: @material, light:, point: @point, eyev:, normalv:)

    assert_equal Color.new(0.1, 0.1, 0.1), result
  end

  test 'lighting the surface in shadow' do
    eyev = Vector.new(0, 0, -1)
    normalv = Vector.new(0, 0, -1)
    light = PointLight.new(Point.new(0, 0, -10), Color.white)
    result = Lighting.light(material: @material, light:, point: @point, eyev:, normalv:, in_shadow: true)

    assert_equal Color.new(0.1, 0.1, 0.1), result
  end


end
