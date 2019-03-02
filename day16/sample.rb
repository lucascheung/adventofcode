class Sample
  attr_accessor :before, :after, :opcode, :a, :b, :c, :possible_ops
  def initialize(attributes)
    @before = attributes[:before]
    @after = attributes[:after]
    @opcode = attributes[:opcode]
    @a = attributes[:a]
    @b = attributes[:b]
    @c = attributes[:c]
  end

  def to_s
    return "before: #{@before}\n#{@opcode} #{@a} #{@b} #{@c}\nafter: #{@after}\n"
  end
end
