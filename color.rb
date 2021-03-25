require_relative './tuple'

class Color < Tuple

  alias :red :x
  alias :green :y
  alias :blue :z

end
