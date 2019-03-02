require 'pry-byebug'
require_relative 'opcode_one'
require_relative 'sample'

total_number = 0

samples = []
(1..3241).each do |line|
  if (line - 1) % 4 == 0 || line - 1 == 0
    before = File.open('day16.input').readlines[line - 1].scan(/\d+/).map(&:to_i)
    second = File.open('day16.input').readlines[line].scan(/\d+/).map(&:to_i)
    opcode = second[0]
    a = second[1]
    b = second[2]
    c = second[3]
    after = File.open('day16.input').readlines[line + 1].scan(/\d+/).map(&:to_i)
    sample = Sample.new(before: before, opcode: opcode, a: a, b: b, c: c, after: after)
    samples << sample
  end
end

def check_num_of_opcodes(sample)
  opcodes = []
  attributes = [sample.before, sample.a, sample.b, sample.c]
  opcodes << 'addr' if addr(*attributes) == sample.after
  opcodes << 'addi' if addi(*attributes) == sample.after
  opcodes << 'mulr' if mulr(*attributes) == sample.after
  opcodes << 'muli' if muli(*attributes) == sample.after
  opcodes << 'banr' if banr(*attributes) == sample.after
  opcodes << 'bani' if bani(*attributes) == sample.after
  opcodes << 'borr' if borr(*attributes) == sample.after
  opcodes << 'bori' if bori(*attributes) == sample.after
  opcodes << 'setr' if setr(*attributes) == sample.after
  opcodes << 'seti' if seti(*attributes) == sample.after
  opcodes << 'gtir' if gtir(*attributes) == sample.after
  opcodes << 'gtri' if gtri(*attributes) == sample.after
  opcodes << 'gtrr' if gtrr(*attributes) == sample.after
  opcodes << 'eqir' if eqir(*attributes) == sample.after
  opcodes << 'eqri' if eqri(*attributes) == sample.after
  opcodes << 'eqrr' if eqrr(*attributes) == sample.after
  sample.possible_ops = opcodes
  return opcodes.length >= 3
end

check_num_of_opcodes(samples[0])

#PART 1------------------------------------------------
samples.each do |sample|
  total_number += 1 if check_num_of_opcodes(sample)
end

puts total_number
#------------------------------------------------------

opcode_bible = {}

while opcode_bible.keys.length < 16
  samples.each do |sample|
    opcode_bible.values.each do |opcode|
      sample.possible_ops.delete(opcode)
    end
    if sample.possible_ops.length == 1
      opcode_bible[sample.opcode] = sample.possible_ops[0]
    end
  end
end
puts opcode_bible

def match_opcode(previous, opcode, a, b, c)
  case opcode
  when 0
    bani(previous, a, b, c)
  when 1
    gtri(previous, a, b, c)
  when 2
    seti(previous, a, b, c)
  when 3
    eqir(previous, a, b, c)
  when 4
    eqrr(previous, a, b, c)
  when 5
    borr(previous, a, b, c)
  when 6
    bori(previous, a, b, c)
  when 7
    banr(previous, a, b, c)
  when 8
    muli(previous, a, b, c)
  when 9
    eqri(previous, a, b, c)
  when 10
    mulr(previous, a, b, c)
  when 11
    gtrr(previous, a, b, c)
  when 12
    setr(previous, a, b, c)
  when 13
    addr(previous, a, b, c)
  when 14
    gtir(previous, a, b, c)
  when 15
    addi(previous, a, b, c)
  end
end

#From opcode_bible result
previous = [0, 0, 0, 0]
(3247..4266).each do |line|
  record = File.open('day16.input').readlines[line - 1].scan(/\d+/).map(&:to_i)
  current = match_opcode(previous, record[0], record[1], record[2], record[3])
  previous = current
end

puts previous[0]



