require_relative './tuple'

class Point < Tuple

  W = 1.0

  def self.origin
    self.new(0, 0, 0)
  end

  def initialize(*args)
    super
    @list << W
  end


end
