require_relative 'errors/tuple_errors'

module PointVectorMath

  W_MAP = {
    0.0 => 'Vector',
    1.0 => 'Point'
  }

  def +(*args)
    tuple_to_concrete_class(super)
  end

  def -(*args)
    tuple_to_concrete_class(super)
  end

  # Returns either a proper Point or Vector depending on the W of the given Tuple
  private def tuple_to_concrete_class(tuple)
    if W_MAP[tuple.w]
      Object.const_get(W_MAP[tuple.w]).new(*tuple.to_a[0,3])
    else
      raise Tuple::UnknownTupleError.new(tuple.w)
    end
  end

end
