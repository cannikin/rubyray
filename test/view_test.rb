require_relative "test_helper"

class ViewTest < Minitest::Test
  test "the transformation matrix for the default orientation" do
    from = Point.origin
    to = Point.new(0, 0, -1)
    up = Vector.new(0, 1, 0)

    assert_equal Matrix.identity, View.transform(from, to, up)
  end

  test "a view transformation matrix looking in positive z direction" do
    from = Point.origin
    to = Point.new(0, 0, 1)
    up = Vector.new(0, 1, 0)

    assert_equal Matrix.scale(-1, 1, -1), View.transform(from, to, up)
  end

  test "the view transformation moves the world" do
    from = Point.new(0, 0, 8)
    to = Point.origin
    up = Vector.new(0, 1, 0)

    assert_equal Matrix.translate(0, 0, -8), View.transform(from, to, up)
  end

  test "an arbitrary view transformation" do
    from = Point.new(1, 3, 2)
    to = Point.new(4, -2, 8)
    up = Vector.new(1, 1, 0)
    expected = Matrix.new([
      [-0.50709, 0.50709, 0.67612, -2.36643],
      [0.76772, 0.60609, 0.12122, -2.82843],
      [-0.35857, 0.59761, -0.71714, 0],
      [0, 0, 0, 1]
    ])

    assert_equal expected, View.transform(from, to, up)
  end
end
