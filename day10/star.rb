class Star
  attr_accessor :x, :y, :x_v, :y_v
  def initialize(x, y, x_v, y_v)
    @x = x
    @y = y
    @x_v = x_v
    @y_v = y_v
    @positions = {}
  end
end
