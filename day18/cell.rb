class Cell
  attr_accessor :x, :y, :type
  def initialize(attributes)
    @x = attributes[:x]
    @y = attributes[:y]
    @type = attributes[:type]
  end

  def to_s
    "[#{@x}, #{@y}] #{@type}"
  end

  def neighbors(grid)
    neighbors = Hash.new(0)
    neighbors[grid[@y - 1][@x].type] += 1 if @y > 0
    neighbors[grid[@y - 1][@x + 1].type] += 1 if @y > 0 && @x < 49
    neighbors[grid[@y][@x + 1].type] += 1 if @x < 49
    neighbors[grid[@y + 1][@x + 1].type] += 1 if @y < 49 && @x < 49
    neighbors[grid[@y + 1][@x].type] += 1 if @y < 49
    neighbors[grid[@y + 1][@x - 1].type] += 1 if @y < 49 && @x > 0
    neighbors[grid[@y][@x - 1].type] += 1 if @x > 0
    neighbors[grid[@y - 1][@x - 1].type] += 1 if @y > 0 && @x > 0
    neighbors
  end
end

