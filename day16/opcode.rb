def addr(bef_reg, aft_reg, a, b, c)
  bef_reg[a] + bef_reg[b] == aft_reg[c]
end

def addi(bef_reg, aft_reg, a, b, c)
  bef_reg[a] + b == aft_reg[c]
end

def mulr(bef_reg, aft_reg, a, b, c)
  bef_reg[a] * bef_reg[b] == aft_reg[c]
end

def muli(bef_reg, aft_reg, a, b, c)
  bef_reg[a] * b == aft_reg[c]
end

def banr(bef_reg, aft_reg, a, b, c)
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
  aft_reg[c] == output.to_i(2)
end

def bani(bef_reg, aft_reg, a, b, c)
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
  aft_reg[c] == output.to_i(2)
end

def borr(bef_reg, aft_reg,a, b, c)
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
  aft_reg[c] == output.to_i(2)
end

def bori(bef_reg, aft_reg, a, b, c)
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
  aft_reg[c] == output.to_i(2)
end

def setr(bef_reg, aft_reg, a, b, c)
  bef_reg[a] == aft_reg[c]
end

def seti(bef_reg, aft_reg, a, b, c)
  a == aft_reg[c]
end

def gtir(bef_reg, aft_reg, a, b, c)
  if a > bef_reg[b] && aft_reg[c] == 1
    true
  elsif a <= bef_reg[b] && aft_reg[c] == 0
    true
  else
    false
  end
end

def gtri(bef_reg, aft_reg, a, b, c)
  if bef_reg[a] > b && aft_reg[c] == 1
    true
  elsif bef_reg[a] <= b && aft_reg[c] == 0
    true
  else
    false
  end
end

def gtrr(bef_reg, aft_reg, a, b, c)
  if bef_reg[a] > bef_reg[b] && aft_reg[c] == 1
    true
  elsif bef_reg[a] <= bef_reg[b] && aft_reg[c] == 0
    true
  else
    false
  end
end

def eqir(bef_reg, aft_reg, a, b, c)
  if a == bef_reg[b] && aft_reg[c] == 1
    true
  elsif a != bef_reg[b] && aft_reg[c] == 0
    true
  else
    false
  end
end

def eqri(bef_reg, aft_reg, a, b, c)
  if bef_reg[a] == b && aft_reg[c] == 1
    true
  elsif bef_reg[a] != b && aft_reg[c] == 0
    true
  else
    false
  end
end

def eqrr(bef_reg, aft_reg, a, b, c)
  if bef_reg[a] == bef_reg[b] && aft_reg[c] == 1
    true
  elsif bef_reg[a] != bef_reg[b] && aft_reg[c] == 0
    true
  else
    false
  end
end
