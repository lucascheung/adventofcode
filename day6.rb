require 'pry-byebug'
require_relative 'location'
require_relative 'coordinate'
a = []
count = 1
File.open('day6.input').each_line do |line|
  # [1518-09-22 23:50] Guard #2309 begins shift
  a << Location.new(count, line.delete("\n").split(", ").map(&:to_i))
  count += 1
end

def infinity(ori, com)
  #plus 1 if not infinity
  # left
  ori.infin[:left] += 1 if ori.x - com.x > (ori.y - com.y).abs
  # up
  ori.infin[:up] += 1 if ori.y - com.y > (ori.x - com.x).abs
  # down
  ori.infin[:down] += 1 if com.y - ori.y > (ori.x - com.x).abs
  # right
  ori.infin[:right] += 1 if com.x - ori.x > (ori.y - com.y).abs
end

a.each do |ori|
  a.each do |com|
    infinity(ori, com)
  end
end

# p a[1]

grid = []
(0..400).each do |x|
  (0..400).each do |y|
    grid << [x,y]
  end
end

def closest(ori, grid)
  ori_to_grid = (grid[0] - ori.x).abs + (grid[1] - ori.y).abs
  return [ori.name, ori_to_grid]
end

grid.each do |point|
  the_closest = [0,1200]
  a.each do |ori|
    distance = closest(ori, point)
    the_closest = [0,distance[1]] if distance[1] == the_closest[1]
    the_closest = distance if distance[1] < the_closest[1]
  end
  unless the_closest[0].zero?
    a[the_closest[0]-1].grid += 1
  end
end

# Part One
b = a.reject {|ori| (ori.infin[:left] * ori.infin[:right] * ori.infin[:up] * ori.infin[:down]).zero? }
# part one answer
p b.max_by(&:grid).grid


x_max = a.max_by {|point| point.x }
y_max = a.max_by {|point| point.y }
# p x_max
# p y_max

grid_two = []
count = 0
(0...y_max.y).each do |y|
  (0...x_max.x).each do |x|
    grid_two << Coordinate.new(count, x, y, 0)
    count += 1
  end
end

def dist(ori, grid)
  ori_to_grid = (grid.x - ori.x).abs + (grid.y - ori.y).abs
  return ori_to_grid
end

grid_two.each do |coordinate|
  distance = 0
  a.each do |point|
    distance += dist(coordinate, point)
  end
  coordinate.distance = distance
end

#Part 2
grid_two.delete_if { |coordinate| coordinate.distance >= 10000 }
p grid_two.length

