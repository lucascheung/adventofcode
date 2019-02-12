class Cell
  attr_accessor :x, :y, :input, :power
  def initialize(x, y, input)
    @x = x
    @y = y
    @input = input
    @power = c_power(x, y, input)
  end

  def c_power(x, y, input)
    id = x + 10
    ((id * y + input) * id).to_s[-3].to_i - 5
  end

  def to_s
    puts "[#{x}, #{y}], power = #{@power}"
  end
end
