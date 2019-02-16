class Recipe
  attr_accessor :number, :next, :previous
  def initialize(number, next_m = nil, previous_m = nil)
    @number = number
    @next = next_m
    @previous = previous_m
  end

  def nexter(number)
    if number > 0
      # puts number
      return self.next.nexter(number - 1)
    end

    return self
  end
end
