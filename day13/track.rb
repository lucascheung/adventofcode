class Track
  attr_accessor :block, :x, :y, :state
  def initialize(attributes)
    @block = attributes[:block]
    @x = attributes[:x]
    @y = attributes[:y]
    @state = 0
  end

  def to_s
    return "#{@block}  #{@x}  #{@y}  #{@state}"
  end
end
