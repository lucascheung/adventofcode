require 'pry-byebug'
require_relative 'unit'
require_relative 'cell'

# build the map
MAP = {}

# to keep track of numbers
$num_goblins = 0
$num_elfs = 0

# list of all gobs and elfs
UNITS = []

LINESIZE = 31
# load file, populate data
File.open('day15.input').each_line.with_index do |line, y_idx|
  MAP[y_idx] = {}
  line.chars.each_with_index do |point, x_idx|
    if point == 'G'
      UNITS << Unit.new(team: point, x: x_idx, y: y_idx)
      $num_goblins += 1
      MAP[y_idx][x_idx] = Cell.new(type: '.', x: x_idx, y: y_idx, occupied: true)
    elsif point == 'E'
      UNITS << Unit.new(team: point, x: x_idx, y: y_idx)
      $num_elfs += 1
      MAP[y_idx][x_idx] = Cell.new(type: '.', x: x_idx, y: y_idx, occupied: true)
    elsif point == '#'
      MAP[y_idx][x_idx] = Cell.new(type: '#', x: x_idx, y: y_idx, occupied: true)
    elsif point == '.'
      MAP[y_idx][x_idx] = Cell.new(type: '.', x: x_idx, y: y_idx, occupied: false)
    end
  end
end

#linking the data
(0..LINESIZE).each do |y_idx|
  (0..LINESIZE).each do |x_idx|
    current = MAP[y_idx][x_idx]
    current.up = MAP[current.y - 1][current.x] unless current.y - 1 < 0
    current.right = MAP[current.y][current.x + 1] unless current.x + 1 > LINESIZE
    current.down = MAP[current.y + 1][current.x] unless current.y + 1 > LINESIZE
    current.left = MAP[current.y][current.x - 1] unless current.x - 1 < 0
  end
end

#Find units in range & in grid
def map_in_range
  clean_grid
  UNITS.each do |unit|
    position = MAP[unit.y][unit.x]
    position.occupied = true
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
  pending_check.sort_by! { |grid| grid.distance * 10000 + grid.y * 100 + grid.x }
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
  in_contact = []
  four_ops.each do |ops|
    if (unit.team == 'G' && ops.elf_in_grid) || (unit.team == 'E' && ops.goblin_in_grid)
      in_contact << UNITS.find { |c_unit| c_unit.x == ops.x && c_unit.y == ops.y }
    end
  end
  return in_contact.min_by{ |unit| unit.hp * 10000 + unit.y * 100 + unit.x }
end

def move(unit)
  direction = find_closest_reachable(unit).origin
  # old_grid = MAP[unit.y][unit.x]
  # switch_nature(unit, old_grid, false)
  unit.y -= 1 if direction == 'up'
  unit.y += 1 if direction == 'down'
  unit.x -= 1 if direction == 'left'
  unit.x += 1 if direction == 'right'
  # new_grid = MAP[unit.y][unit.x]
  # switch_nature(unit, new_grid, true)
  map_in_range
end

def switch_nature(unit, grid, boolean)
  grid.occupied = boolean
  if unit.team == 'G'
    grid.goblin_in_grid = boolean
    grid.up.goblin_in_range = boolean unless grid.y - 1 < 0
    grid.down.goblin_in_range = boolean unless grid.y + 1 > LINESIZE
    grid.left.goblin_in_range = boolean unless grid.x - 1 < 0
    grid.right.goblin_in_range = boolean unless grid.x + 1 > LINESIZE
  elsif unit.team == 'E'
    grid.elf_in_grid = boolean
    grid.up.elf_in_range = boolean unless grid.y - 1 < 0
    grid.down.elf_in_range = boolean unless grid.y + 1 > LINESIZE
    grid.left.elf_in_range = boolean unless grid.x - 1 < 0
    grid.right.elf_in_range = boolean unless grid.x + 1 > LINESIZE
  end
end

def attack(unit, ori_unit)
  unit.hp -= ELF_ATTACKING_POWER if unit.team == 'G'
  unit.hp -= 3 if unit.team == 'E'

  if unit.hp <= 0
    grid = MAP[unit.y][unit.x]
    if unit.team == 'G'
      $num_goblins -= 1
    elsif unit.team == 'E'
      $num_elfs -= 1
    end
    killed_before = true if unit.x < ori_unit.x || unit.y < ori_unit.y
    UNITS.delete(unit)
    map_in_range
    return killed_before
  end
end

def clean_grid
  (0..LINESIZE).each do |y_idx|
    (0..LINESIZE).each do |x_idx|
      grid = MAP[y_idx][x_idx]
      grid.distance = 0
      grid.origin = nil
      grid.goblin_in_range = false
      grid.elf_in_range = false
      grid.elf_in_grid = false
      grid.goblin_in_grid = false
      grid.occupied = false unless grid.type == '#'
    end
  end
end

def render_grid
  (0..LINESIZE).each do |y_idx|
    line = ""
    (0..LINESIZE).each do |x_idx|
      if MAP[y_idx][x_idx].goblin_in_grid
        line += 'G'
      elsif MAP[y_idx][x_idx].elf_in_grid
        line += 'E'
      else
        line += MAP[y_idx][x_idx].type
      end
    end
    puts line
  end
end


#START THE GAME

map_in_range
render_grid

#FOR PART 2, change to 3 for part 1
ELF_ATTACKING_POWER = 25


round = 0
while $num_goblins > 0 && $num_elfs > 0
  unit_idx = 0
  while unit_idx < UNITS.length && $num_goblins > 0 && $num_elfs > 0
    killed_before = false
    if in_contact_with_enemy?(UNITS[unit_idx])
      killed_before = attack(closest_enemy_in_contact(UNITS[unit_idx]), UNITS[unit_idx])
    elsif !find_closest_reachable(UNITS[unit_idx]).nil?
      move(UNITS[unit_idx])
      if in_contact_with_enemy?(UNITS[unit_idx])
        killed_before = attack(closest_enemy_in_contact(UNITS[unit_idx]), UNITS[unit_idx])
      end
    end
    unit_idx += 1 unless killed_before
  end
  round += 1
  puts "-------------------After #{round} rounds---"
  UNITS.sort_by! { |unit| (unit.y * 1000) + unit.x }
  UNITS.each { |unit| puts unit }
  render_grid
  # puts $num_goblins
  # puts $num_elfs
end

sum = 0

UNITS.each do |unit|
  puts unit
  sum += unit.hp
end


#PART 1 & 2
puts UNITS.length
result = (round - 1) * sum
puts round
puts sum
puts result
