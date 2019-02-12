class Marble
  attr_accessor :number, :next, :previous
  def initialize(number, next_m = nil, previous_m = nil)
    @number = number
    @next = next_m
    @previous = previous_m
  end
end
