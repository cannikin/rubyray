class IntersectionCollection

  attr_reader :members

  def initialize(*intersections)
    @members = intersections
  end

  def [](index)
    members[index]
  end

  def size
    members.size
  end

end
