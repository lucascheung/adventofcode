class Worker
  attr_accessor :name, :available, :time, :assigned
  def initialize(name)
    @name = name
    @available = true
    @time = 0
  end
  def to_s
    return "#{@name}, #{@available}, #{@time}, #{assigned}"
  end
end
