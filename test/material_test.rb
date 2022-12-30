require_relative 'test_helper'

class MaterialTest < Minitest::Test

  test 'the default material' do
    material = Material.new

    assert_equal Color.new(1, 1, 1), material.color
    assert_equal Material::DEFAULT_ATTRS[:ambient], material.ambient
    assert_equal Material::DEFAULT_ATTRS[:diffuse], material.diffuse
    assert_equal Material::DEFAULT_ATTRS[:specular], material.specular
    assert_equal Material::DEFAULT_ATTRS[:shininess], material.shininess
  end

end
