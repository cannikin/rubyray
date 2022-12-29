require_relative './color'

class Material

  DEFAULT_ATTRS = { color: Color.new(1, 1, 1),
                    ambient: 0.1,
                    diffuse: 0.9,
                    specular: 0.9,
                    shininess: 200.0 }

  attr_reader :color, :ambient, :diffuse, :specular, :shininess

  def initialize(opts = {})
    options = DEFAULT_ATTRS.merge(opts)

    @color = options[:color]
    @ambient = options[:ambient]
    @diffuse = options[:diffuse]
    @specular = options[:specular]
    @shininess = options[:shininess]
  end

end
