module PointVectorMath

  W_MAP = {
    0.0 => 'Vector',
    1.0 => 'Point'
  }

  def +(*args)
    tuple = super
    # return either a proper Point or Vector depending on what w ends up being
    Object.const_get(W_MAP[tuple.w]).new(*tuple.to_a[0,3])
  end

  def -(*args)
    tuple = super
    # return either a proper Point or Vector depending on what w ends up being
    Object.const_get(W_MAP[tuple.w]).new(*tuple.to_a[0,3])
  end

end
