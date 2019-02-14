class Coordinate
  attr_accessor :name, :x, :y, :distance
  def initialize(name, x, y, distance)
    @name = name
    @x = x
    @y = y
    @distance = distance
  end
end
