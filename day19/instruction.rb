class Instruction
  attr_accessor :opcode, :a, :b, :c
  def initialize(attributes)
    @opcode = attributes[:opcode]
    @a = attributes[:a]
    @b = attributes[:b]
    @c = attributes[:c]
  end

  def to_s
    "#{@opcode} #{@a} #{@b} #{@c}"
  end
end
