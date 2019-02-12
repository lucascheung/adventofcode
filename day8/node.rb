class Node
  attr_accessor :idx, :pos, :layer, :meta, :entries, :meta_sum, :child
  def initialize(attributes)
    @idx = attributes[:idx]
    @pos = attributes[:pos]
    @layer = attributes[:layer]
    @meta = attributes[:meta]
    @entries = attributes[:entries]
    @meta_sum = @meta.sum
    @child = []
  end

  def to_s
    return "#{idx} #{@layer} #{@meta} #{@entries} #{meta_sum}"
  end
end
