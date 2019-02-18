require 'pry-byebug'
require_relative 'unit'
require_relative 'grid'

# build the map
MAP = {}

# to keep track of numbers
init_goblins = 0
init_elfs = 0

# list of all gobs and elfs
GOBLINS = []
ELFS = []

# load file, populate data
File.open('day15.input').each_line.with_index do |line, y_idx|
  MAP[y_idx] = {}
  line.chars.each_with_index do |point, x_idx|
    if point == 'G'
      GOBLINS << Unit.new(team: point, x: x_idx, y: y_idx)
      init_goblins += 1
      MAP[y_idx][x_idx] = Grid.new(type: '.', x: x_idx, y: y_idx, occupied: true)
    elsif point == 'E'
      ELFS << Unit.new(team: point, x: x_idx, y: y_idx)
      init_elfs += 1
      MAP[y_idx][x_idx] = Grid.new(type: '.', x: x_idx, y: y_idx, occupied: true)
    elsif point == '#'
      MAP[y_idx][x_idx] = Grid.new(type: '#', x: x_idx, y: y_idx, occupied: true)
    elsif point == '.'
      MAP[y_idx][x_idx] = Grid.new(type: '.', x: x_idx, y: y_idx, occupied: false)
    end
  end
end

#linking the data
(0..31).each do |y_idx|
  (0..31).each do |x_idx|
    current = MAP[y_idx][x_idx]
    current.up = MAP[current.y - 1][current.x] unless current.y - 1 < 0
    current.right = MAP[current.y][current.x + 1] unless current.x + 1 > 31
    current.down = MAP[current.y + 1][current.x] unless current.y + 1 > 31
    current.left = MAP[current.y][current.x - 1] unless current.x - 1 < 0
  end
end

#Find goblins in range
GOBLINS.each do |goblin|
  position = MAP[goblin.y][goblin.x]
  position.up.goblin_in_range = true if position.up.type == '.'
  position.right.goblin_in_range = true if position.right.type == '.'
  position.down.goblin_in_range = true if position.down.type == '.'
  position.left.goblin_in_range = true if position.left.type == '.'
end

#find elfs in range
ELFS.each do |elf|
  position = MAP[elf.y][elf.x]
  position.up.elf_in_range = true if position.up.type == '.'
  position.right.elf_in_range = true if position.right.type == '.'
  position.down.elf_in_range = true if position.down.type == '.'
  position.left.elf_in_range = true if position.left.type == '.'
end

# GOBLINS.each { |g| puts g }
# ELFS.each { |g| puts g }
# MAP.each { |k,v| puts v.values }

def reachables(current)
  pending_check = [current]
  pending_idx = 0
  while pending_idx < pending_check.length
    current = pending_check[pending_idx]
    distance = current.distance.nil? ? 0 : current.distance
    four_ops = [current.up, current.right, current.down, current.left]
    four_ops.each do |ops|
      if valid_free_not_include?(ops, pending_check)
        pending_check << ops
        ops.distance = distance + 1
        adding_new_layer(ops.up, pending_check, distance)
        adding_new_layer(ops.left, pending_check, distance)
        adding_new_layer(ops.right, pending_check, distance)
        adding_new_layer(ops.down, pending_check, distance)
      end
    end
    pending_idx += 1
  end
  pending_check.delete_at(0)
  pending_check.delete_if { |grid| grid.distance == 1 }
  return pending_check
end

def adding_new_layer(ops, pending_check, distance)
  if valid_free_not_include?(ops, pending_check)
    ops.distance = distance + 2
    pending_check << ops
  end
end

def valid_free_not_include?(ops, pending_check)
  return true unless ops.nil? || ops.occupied || pending_check.include?(ops)
end

def find_closest_reachable(unit)
  if unit.team == "G"
    reachables(MAP[unit.y][unit.x]).select { |grid| grid.elf_in_range }[0]
  else
    reachables(MAP[unit.y][unit.x]).select { |grid| grid.goblin_in_range }[0]
  end
end


puts GOBLINS[8]
puts find_closest_reachable(GOBLINS[8])
# puts reachables(MAP[GOBLINS[0].y][GOBLINS[0].x]).select {|grid| grid.goblin_in_range }[0]




#Objective: number of rounds * hit points left

