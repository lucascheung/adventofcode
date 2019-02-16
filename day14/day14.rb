require 'pry-byebug'
require_relative 'recipe'


recipe_size = 22000000

three = Recipe.new(3)
seven = Recipe.new(7)

first = three
last = seven

circle = first
square = last

three.next = seven
three.previous = seven
seven.next = three
seven.next = three

next_add = circle.number + square.number

def arrange_one(new_one, first, last)
  new_one.previous = last
  new_one.next = first
  first.previous = new_one
  last.next = new_one
end

def arrange_two(new_one, new_two, first, last)
  new_one.previous = last
  new_one.next = new_two
  new_two.previous = new_one
  new_two.next = first
  first.previous = new_two
  last.next = new_one
end

recipe_size.times do
  if next_add.to_s[1]
    add_one = next_add.to_s[0].to_i
    add_two = next_add.to_s[1].to_i
    new_one = Recipe.new(add_one)
    new_two = Recipe.new(add_two)
    arrange_two(new_one, new_two, first, last)
    last = new_two
  else
    new_one = Recipe.new(next_add)
    arrange_one(new_one, first, last)
    last = new_one
  end

  c_move = circle.number + 1
  s_move = square.number + 1

  c_move.times { circle = circle.next }
  s_move.times { square = square.next }
  # circle = circle.nexter(c_move)
  # square = square.nexter(s_move)

  next_add = circle.number + square.number
end

#PART ONE##############################################
puzzle_input = 170641
recipe_start = first
(puzzle_input - 1).times { recipe_start = recipe_start.next }


final_num = ""
10.times do
  recipe_start = recipe_start.next
  final_num += recipe_start.number.to_s
end

puts final_num


#PART TWO###############################################
matched = false
position = 1
header = first
matcher = ""
until matched
  target = "170641"
  matcher += header.next.number.to_s
  matcher += header.next.next.number.to_s
  matcher += header.next.next.next.number.to_s
  matcher += header.next.next.next.next.number.to_s
  matcher += header.next.next.next.next.next.number.to_s
  matcher += header.next.next.next.next.next.next.number.to_s

  if matcher == target
    puts position
    matched = true
  else
    position += 1
    # puts matcher
    matcher = ""
    header = header.next
  end
end

#20165733











