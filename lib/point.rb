require_relative './tuple'

class Point < Tuple

  W = 1.0

  def initialize(*args)
    super
    @list << W
  end

end
