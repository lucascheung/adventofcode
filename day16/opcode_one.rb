def addr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] + bef_reg[b]
  result
end

def addi(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] + b
  result
end

def mulr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] * bef_reg[b]
  result
end

def muli(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] * b
  result
end

def banr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  output = ""
  x = "%04b" % bef_reg[a]
  y = "%04b" % bef_reg[b]
  (0..3).each do |idx|
    if x[idx] == '1' && y[idx] == '1'
      output += '1'
    else
      output += '0'
    end
  end
  result[c] = output.to_i(2)
  result
end

def bani(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  output = ""
  x = "%04b" % bef_reg[a]
  y = "%04b" % b
  (0..3).each do |idx|
    if x[idx] == '1' && y[idx] == '1'
      output += '1'
    else
      output += '0'
    end
  end
  result[c] = output.to_i(2)
  result
end

def borr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  output = ""
  x = "%04b" % bef_reg[a]
  y = "%04b" % bef_reg[b]
  (0..3).each do |idx|
    if x[idx] == '0' && y[idx] == '0'
      output += '0'
    else
      output += '1'
    end
  end
  result[c] = output.to_i(2)
  result
end

def bori(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  output = ""
  x = "%04b" % bef_reg[a]
  y = "%04b" % b
  (0..3).each do |idx|
    if x[idx] == '0' && y[idx] == '0'
      output += '0'
    else
      output += '1'
    end
  end
  result[c] = output.to_i(2)
  result
end

def setr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a]
  result
end

def seti(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = a
  result
end

def gtir(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = a > bef_reg[b] ? 1 : 0
  result
end

def gtri(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] > b ? 1 : 0
  result
end

def gtrr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] > bef_reg[b] ? 1 : 0
  result
end

def eqir(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = a == bef_reg[b] ? 1 : 0
  result
end

def eqri(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] == b ? 1 : 0
  result
end

def eqrr(bef_reg, a, b, c)
  result = Array.new(bef_reg)
  result[c] = bef_reg[a] == bef_reg[b] ? 1 : 0
  result
end
