require_relative "test_helper"

class PPMTest < Minitest::Test
  test "#initialize with a canvas" do
    canvas = Canvas.new(4, 5)
    ppm = PPM.new(canvas)

    assert_equal canvas, ppm.canvas
  end

  test "#to_s returns ppm header data" do
    canvas = Canvas.new(4, 5)
    ppm = PPM.new(canvas)
    lines = ppm.to_s.split("\n")

    assert_equal PPM::IDENTIFIER, lines[0]
    assert_equal "#{canvas.width} #{canvas.height}", lines[1]
    assert_equal PPM::MAX_COLOR_VALUE.to_s, lines[2]
  end

  test "#to_s returns ppm color data" do
    canvas = Canvas.new(5, 3)
    color1 = Color.new(1.5, 0, 0)
    color2 = Color.new(0, 0.5, 0)
    color3 = Color.new(-0.5, 0, 1)
    canvas.write(0, 0, color1)
    canvas.write(2, 1, color2)
    canvas.write(4, 2, color3)
    ppm = PPM.new(canvas)
    lines = ppm.to_s.split("\n")

    assert_equal "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0", lines[3]
    assert_equal "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0", lines[4]
    assert_equal "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255", lines[5]
  end

  test "#to_s wraps lines at 70 characters" do
    canvas = Canvas.new(10, 2)
    canvas.fill(Color.new(1, 0.8, 0.6))
    ppm = PPM.new(canvas)
    lines = ppm.to_s.split("\n")

    assert_equal "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204", lines[3]
    assert_equal "153 255 204 153 255 204 153 255 204 153 255 204 153", lines[4]
    assert_equal "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204", lines[5]
    assert_equal "153 255 204 153 255 204 153 255 204 153 255 204 153", lines[6]
  end

  test "#to_s ends in a newline" do
    canvas = Canvas.new(10, 2)
    ppm = PPM.new(canvas)
    lines = ppm.to_s

    assert_equal "\n", lines[-1]
  end
end
