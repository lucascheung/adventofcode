class Cell
  attr_accessor :clay, :water, :x, :y
  def initialize(attributes)
    @clay = attributes[:clay]
    @water = ''
    @x = attributes[:x]
    @y = attributes[:y]
  end

  def to_s
    "[#{@x}, #{@y}] clay: #{@clay} water: #{water}"
  end

  def up
    GRID[@y - 1][@x]
  end

  def down
    GRID[@y + 1][@x]
  end

  def left
    GRID[@y][@x - 1]
  end

  def right
    GRID[@y][@x + 1]
  end
end
