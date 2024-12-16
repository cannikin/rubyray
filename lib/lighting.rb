require_relative "color"

class Lighting
  def self.light(opts = {})
    options = {in_shadow: false}.merge(opts)
    options => { material:, light:, point:, eyev:, normalv:, in_shadow: }
    _, diffuse, specular = Color.black, Color.black, Color.black

    # combine surface color with the light's color/itensity
    effective_color = material.color * light.intensity

    # find the direction to the light source
    lightv = (light.position - point).normalize

    # compute the ambient contribution
    ambient = effective_color * material.ambient

    return ambient if in_shadow

    # cosine of the angle between the light vector and the normal vector
    # a negative number means the light is on the other side of the surface
    light_dot_normal = lightv.dot(normalv)

    # can we actually see the light?
    if light_dot_normal >= 0
      # compute the diffuse contribution
      diffuse = effective_color * material.diffuse * light_dot_normal

      # cosine of the angle between the reflection vector and the eye vector
      # negative number means the light reflects away from the eye
      reflectv = -lightv.reflect(normalv)
      reflect_dot_eye = reflectv.dot(eyev)

      # can we see a specular highlight?
      if reflect_dot_eye > 0
        factor = reflect_dot_eye**material.shininess
        specular = light.intensity * material.specular * factor
      end
    end

    ambient + diffuse + specular
  end
end
