require_relative 'cell'


GRID = {}

File.open('day18.input').each_line.with_index do |line, y_idx|
  GRID[y_idx] = {}
  line.chop.chars.each_with_index do |type, x_idx|
    GRID[y_idx][x_idx] = Cell.new(x: x_idx, y: y_idx, type: type)
  end
end

def new_type(cell, grid)
  if cell.type == '.' && cell.neighbors(grid)['|'] >= 3
    '|'
  elsif cell.type == '|' && cell.neighbors(grid)['#'] >= 3
    '#'
  elsif cell.type == '#' && (cell.neighbors(grid)['#'] < 1 || cell.neighbors(grid)['|'] < 1)
    '.'
  else
    cell.type
  end
end

def render_map(grid)
  (0..49).each do |y_idx|
    line = ''
    (0..49).each do |x_idx|
      line += grid[y_idx][x_idx].type
    end
    puts line
  end
end

def calculate_resource_value(grid)
  wood = 0
  lumberyards = 0
  (0..49).each do |y_idx|
    (0..49).each do |x_idx|
      wood += 1 if grid[y_idx][x_idx].type == '|'
      lumberyards += 1 if grid[y_idx][x_idx].type == '#'
    end
  end
  wood * lumberyards
end

current = GRID
count = 0

1000.times do
  new_grid = {}
  (0..49).each do |y_idx|
    new_grid[y_idx] = {}
    (0..49).each do |x_idx|
      new_cell = Cell.new(x: x_idx, y: y_idx, type: new_type(current[y_idx][x_idx], current))
      new_grid[y_idx][x_idx] = new_cell
    end
  end
  current = new_grid
  count += 1
end


#PART ONE ANSWER ----- CHANGE TO 10 TIMES
#PART TWO ANSWER ----- CHANGE TO 1000 TIMES (28 is one cycle)

puts calculate_resource_value(current)


