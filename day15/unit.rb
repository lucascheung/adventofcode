class Unit
  attr_accessor :team, :x, :y, :hp
  def initialize(attributes)
    @team = attributes[:team]
    @x = attributes[:x]
    @y = attributes[:y]
    @hp = 200
  end

  def attack
  end

  def to_s
    "#{@team} [#{@x}, #{@y}] hp:#{@hp}"
  end
end
