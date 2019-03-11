require 'pry-byebug'
require_relative 'instruction'
require_relative 'opcode'

program = []
ip_bound = 0
register = [1, 0, 0, 0, 0, 0]

File.open('day19.input').each_line.with_index do |line, idx|
  if idx == 0
    ip_bound = line[4].to_i
  else
    data = line.split(' ')
    program << Instruction.new(opcode: data[0], a: data[1].to_i, b: data[2].to_i, c: data[3].to_i)
  end
end


current_reg = register
ip = 0

while ip < program.length
  current_reg[ip_bound] = ip
  new_reg = send(program[ip].opcode, current_reg, program[ip].a, program[ip].b, program[ip].c)
  p ip
  puts program[ip]
  # p current_reg
  p new_reg
  # binding.pry
  ip = new_reg[ip_bound] + 1
  current_reg = new_reg
end

p current_reg

# total = 0
# (1..892).each do |number|
#   total += number
# end
# puts total

