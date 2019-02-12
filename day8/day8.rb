require 'pry-byebug'
require_relative 'node'

a = []

File.open('day8.input').each_line do |line|
  a << line.chop.split(" ")
end
a = a[0].map(&:to_i)


# meta_sum = 0

# idx = 0
# while a.length > 0
#   idx = 0 if idx == a.length - 1
#   if a[idx] == 0
#     entries = a[idx + 1]
#     (1..entries).each do |entry|
#       meta_sum += a[idx + 1 + entry]
#     end
#     a[idx - 2] -= 1
#     (idx..idx + 1 + entries).each do |entry|
#       a.delete_at(idx)
#     end
#   else
#     idx += 1
#   end
# end

# # PART ONE ANSWER
# p meta_sum

b = {}
count = 1
a.each_with_index do |num, idx|
  b[idx + 1] = num
end

# p b

nodes = []

meta = []
layer = 0
idx = 0
pos = 1
ori_pos = 1

# def next_pos(idx, b)
#   return idx + 1 unless b[idx + 1].nil?

#   next_pos(idx + 1, b)
# end

def next_pos(idx,b)
  count = 1
  while b[idx + 1 + count].nil?
    count += 1
  end
  return idx + count
end


# def back(idx, b)
#   return idx - 2 unless b[idx - 1].nil?

#   back(idx - 1, b)
# end

def back(idx,b)
  count = 1
  while b[idx - count].nil?
    count += 1
  end
  return idx - count - 1
end

while b.length > 0
  if idx > 18570
    # binding.pry
    layer += 1
    idx = 1
  end
  if b[idx] == 0
    entries = b[idx + 1]
    (1..entries).each do |entry|
      meta << b[next_pos(idx, b) + entry]
    end
    attributes = {idx:idx, pos:pos, layer:layer, entries:entries, meta:meta}
    node = Node.new(attributes)
    nodes << node
    pos += 1
    meta = []
    b[back(idx, b)] -= 1 if idx != 1
    b.delete(idx)
    b.delete(idx + 1)
    del = next_pos(idx, b)
    del_end = del + entries
    (del..del_end).each do |entry|
      b.delete(entry)
    end
    # puts node
  else
    idx += 1
  end
end



n_nodes = nodes.sort_by{ |node| node.idx }


n_nodes.each_with_index do |node, idx|
  if node.layer == 1
    node.meta_sum = 0
    node.meta.each do |entry|
      node.meta_sum += n_nodes[idx + 1].meta_sum if entry == 1
    end
  end
end


one_nodes = n_nodes.select { |node| node.layer == 1 }
two_nodes = nodes.select { |node| node.layer == 2 }
three_nodes = nodes.select { |node| node.layer == 3 }
four_nodes = nodes.select { |node| node.layer == 4 }
five_nodes = nodes.select { |node| node.layer == 5 }

GROUP = [one_nodes, two_nodes, three_nodes, four_nodes, five_nodes]

def find_children (level)
  s_nodes = GROUP[level]
  b_nodes = GROUP[level + 1]
  s_nodes.each do |o|
    count = 0
    done = false
    while !done
      if level == 3 || b_nodes[count] == b_nodes.last
        b_nodes[-1].child << o
        done = true
      elsif o.idx > b_nodes[count].idx && o.idx < b_nodes[count + 1].idx
        b_nodes[count].child << o
        done = true
      else
        count += 1
      end
    end
  end
end

def find_meta_sum (level)
  b_nodes = GROUP[level + 1]
  b_nodes.each do |node|
    node.meta_sum = 0
    node.meta.each do |meta|
      node.meta_sum += node.child[meta - 1].meta_sum unless node.child[meta - 1].nil?
    end
  end
end

(0..3).each do |level|
  find_children(level)
  find_meta_sum(level)
end

# binding.pry

puts n_nodes.select {|node| node.layer == 0 }
GROUP.each do |nodes|
  nodes.each do |node|
    puts node
  end
end

total = 0
five_nodes.each do |node|
  total += node.meta_sum
end
puts total

