require_relative './test_helper'
require_relative '../lib/intersection_collection'
require_relative '../lib/intersection'

class IntersectionCollectionTest < Minitest::Test

  test 'aggregating intersections' do
    sphere = Sphere.new
    int1 = Intersection.new(1, sphere)
    int2 = Intersection.new(2, sphere)
    col = IntersectionCollection.new(int1, int2)

    assert_equal 2, col.size
    assert_equal int1, col[0]
    assert_equal int2, col[1]
  end

end
