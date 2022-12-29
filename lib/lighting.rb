require_relative './color'

class Lighting

  def self.light(opts)
    ambient, diffuse, specular =  nil

    opts => { material:, light:, point:, eyev:, normalv: }

    # combine surface color with the light's color/itensity
    effective_color = material.color * light.intensity

    # find the direction to the light source
    lightv = (light.position - point).normalize

    # compute the ambient contribution
    ambient = effective_color * material.ambient

    # cosine of the angle between the light vector and the normal vector
    # a negative number means the light is on the other side of the surface
    light_dot_normal = lightv.dot(normalv)

    # can we actually see the light?
    if light_dot_normal < 0
      diffuse = Color.black
      specular = Color.black
    else
      # compute the diffuse contribution
      diffuse = effective_color * material.diffuse * light_dot_normal

      # cosine of the angle between the reflection vector and the eye vector
      # negative number means the light reflects away from the eye
      reflectv = -(lightv).reflect(normalv)
      reflect_dot_eye = reflectv.dot(eyev)

      # can we see a specular highlight?
      if reflect_dot_eye <= 0
        specular = Color.black
      else
        factor = reflect_dot_eye ** material.shininess
        specular = light.intensity * material.specular * factor
      end
    end

    return ambient + diffuse + specular
  end

end
