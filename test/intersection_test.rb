require_relative './test_helper'
require_relative '../lib/intersection'
require_relative '../lib/sphere'

class IntersectionTest < Minitest::Test

  test 'an intersection encapsulates t and object' do
    sphere = Sphere.new
    intersection = Intersection.new(3.5, sphere)

    assert_equal 3.5, intersection.t
    assert_equal sphere, intersection.object
  end

end
