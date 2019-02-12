class Cart
  attr_accessor :direction, :x, :y, :name
  def initialize(attributes)
    @name = attributes[:name]
    @direction = attributes[:direction]
    @x = attributes[:x]
    @y = attributes[:y]
    @next_turn = 'left'
  end

  def corner(block)
    if block == "\\"
      if @direction == '>'
        @direction = 'v'
      elsif @direction == '<'
        @direction = '^'
      elsif @direction == 'v'
        @direction = '>'
      else
        @direction = '<'
      end
    end

    if block == '/'
      if @direction == '>'
        @direction = '^'
      elsif @direction == '<'
        @direction = 'v'
      elsif @direction == 'v'
        @direction = '<'
      else
        @direction = '>'
      end
    end
  end

  def turn
    right_seq = ['>', '^', '<', 'v']
    left_seq = ['<', '^', '>', 'v']
    if @next_turn == 'right'
      @direction = right_seq[right_seq.index(@direction) - 1]
    elsif @next_turn == 'left'
      @direction = left_seq[left_seq.index(@direction) - 1]
    end
    @turn_seq = ['right', 'straight', 'left']
    @next_turn = @turn_seq[@turn_seq.index(@next_turn) - 1]
  end

  def move
    @x += 1 if @direction == '>'
    @x -= 1 if @direction == '<'
    @y -= 1 if @direction == '^'
    @y += 1 if @direction == 'v'
  end

  def to_s
    return "#{name} #{@direction} #{@x} #{@y} #{@next_turn}"
  end
end
