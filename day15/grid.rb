class Grid
  attr_accessor :type, :x, :y, :in_range, :occupied
  attr_accessor :up, :down, :left, :right, :distance
  attr_accessor :goblin_in_range, :elf_in_range, :origin
  attr_accessor :goblin_in_grid, :elf_in_grid
  def initialize(attributes)
    @type = attributes[:type]
    @x = attributes[:x]
    @y = attributes[:y]
    @elf_in_range = false
    @goblin_in_range = false
    @occupied = attributes[:occupied]
  end

  def to_s
    "[#{@x}, #{@y}] | type: #{@type} | occupied: #{@occupied} | distance: #{@distance} | origin: #{origin}"
  end
end
