class Location
  attr_reader :x, :y, :name
  attr_accessor :infin, :grid
  def initialize(name, cor)
    @name = name
    @x = cor[0]
    @y = cor[1]
    @infin = { left: 0, up: 0, down: 0, right: 0 }
    @grid = 0
  end
end
