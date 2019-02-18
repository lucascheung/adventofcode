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
UNITS = []

# load file, populate data
File.open('day15.input').each_line.with_index do |line, y_idx|
  MAP[y_idx] = {}
  line.chars.each_with_index do |point, x_idx|
    if point == 'G'
      UNITS << Unit.new(team: point, x: x_idx, y: y_idx)
      init_goblins += 1
      MAP[y_idx][x_idx] = Grid.new(type: '.', x: x_idx, y: y_idx, occupied: true)
    elsif point == 'E'
      UNITS << Unit.new(team: point, x: x_idx, y: y_idx)
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

#Find units in range & in grid
UNITS.each do |unit|
  position = MAP[unit.y][unit.x]
  if unit.team == 'G'
    position.goblin_in_grid = true
    position.up.goblin_in_range = true if position.up.type == '.'
    position.right.goblin_in_range = true if position.right.type == '.'
    position.down.goblin_in_range = true if position.down.type == '.'
    position.left.goblin_in_range = true if position.left.type == '.'
  else
    position.elf_in_grid = true
    position.up.elf_in_range = true if position.up.type == '.'
    position.right.elf_in_range = true if position.right.type == '.'
    position.down.elf_in_range = true if position.down.type == '.'
    position.left.elf_in_range = true if position.left.type == '.'
  end
end

# MAP.each { |k,v| puts v.values }

def reachables(current)
  pending_check = [current]
  pending_idx = 0
  while pending_idx < pending_check.length
    current = pending_check[pending_idx]
    distance = current.distance.nil? ? 0 : current.distance
    four_ops = [current.up, current.left, current.right, current.down]
    direction = %w[up left right down]
    four_ops.each_with_index do |ops, idx|
      if valid_free_not_include?(ops, pending_check)
        pending_check << ops
        ops.distance = distance + 1
        root_direction(distance, direction, ops, idx)
        adding_new_layer(ops.up, pending_check, distance, direction, idx, ops)
        adding_new_layer(ops.left, pending_check, distance, direction, idx, ops)
        adding_new_layer(ops.right, pending_check, distance, direction, idx, ops)
        adding_new_layer(ops.down, pending_check, distance, direction, idx, ops)
      end
    end
    pending_idx += 1
  end
  pending_check.delete_at(0)
  return pending_check
end

def root_direction(distance, direction, ops, idx)
  if distance == 0
    ops.origin = direction[idx]
  else
    ops.origin = ops.down.origin if idx == 0
    ops.origin = ops.right.origin if idx == 1
    ops.origin = ops.left.origin if idx == 2
    ops.origin = ops.up.origin if idx == 3
  end
end

def adding_new_layer(ops, pending_check, distance, direction, idx, ops_root)
  if valid_free_not_include?(ops, pending_check)
    ops.distance = distance + 2
    ops.origin = ops_root.origin
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

def in_contact_with_enemy?(unit)
  unit_grid = MAP[unit.y][unit.x]
  if unit.team == 'G'
    return true if unit_grid.elf_in_range == true
  elsif unit.team == 'E'
    return true if unit_grid.goblin_in_range == true
  end
end

def closest_enemy_in_contact(unit)
  grid = MAP[unit.y][unit.x]
  four_ops = [grid.up, grid.left, grid.right, grid.down]
  four_ops.each do |ops|
    if (unit.team == 'G' && ops.elf_in_grid) || (unit.team == 'E' && ops.goblin_in_grid)
      return UNITS.find { |unit| unit.x == ops.x && unit.y == ops.y }
    end
  end
end


UNITS.each do |unit|
  puts unit
  if in_contact_with_enemy?(unit)
    puts closest_enemy_in_contact(unit)
  else
    puts find_closest_reachable(unit)
  end
end
# puts reachables(MAP[GOBLINS[0].y][GOBLINS[0].x]).select {|grid| grid.goblin_in_range }[0]




#Objective: number of rounds * hit points left


