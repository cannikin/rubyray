require_relative './tuple'

def point(*args)
  Tuple.new(*(args << Tuple::POINT_W))
end

def vector(*args)
  Tuple.new(*(args << Tuple::VECTOR_W))
end
