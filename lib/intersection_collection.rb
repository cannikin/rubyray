class IntersectionCollection

  attr_reader :members

  def initialize(*intersections)
    @members = intersections.sort_by { |int| int.t }
  end

  def [](index)
    members[index]
  end

  def size
    members.size
  end

  # returns the first non-negative intersection
  def hit
    members.find { |int| int.t >= 0 }
  end

  def hit?
    !hit.nil?
  end

end
