require 'pry-byebug'
require_relative 'cell'

matrix = {}
input = 4172

(1..300).each do |y|
  matrix[y] = {}
  (1..300).each do |x|
    cell = Cell.new(x, y, input)
    matrix[y][x] = cell
  end
end

largest = 0


#PART 1
# (1..298).each do |y|
#   (1..298).each do |x|
#     current = 0
#     current += matrix[y][x].power
#     current += matrix[y + 1][x].power
#     current += matrix[y + 2][x].power
#     current += matrix[y][x + 1].power
#     current += matrix[y + 1][x + 1].power
#     current += matrix[y + 2][x + 1].power
#     current += matrix[y][x + 2].power
#     current += matrix[y + 1][x + 2].power
#     current += matrix[y + 2][x + 2].power
#     if current > largest
#       largest = current
#       p [x,y]
#     end
#   end
# end


# def find_largest (x,y, matrix)
#   top_cell = [0,0,0]
#   top_power = 0
#   max = 300 - [x,y].max
#   (1..max).each do |size|
#     (y..y+size).each do |b|
#       (x..x+size).each do |a|
#         total = 0
#         total += matrix[b][a].power
#         if total > top_power
#           top_power = total
#           top_cell = [x,y,size]
#         end
#       end
#     end
#   end
#   return [top_power, top_cell]
# end

#PART 2
def find_best_point(d,matrix)
  max_cell = [0,0,0]
  max_power = 0
  (1..298).each do |y|
    (1..298).each do |x|
      if d < 300 - [x,y].max
        total = 0
        (y..y+d).each do |b|
          (x..x+d).each do |a|
            total += matrix[b][a].power
          end
        end
        if total > max_power
          max_power = total
          max_cell = [x,y,d]
        end
      end
    end
  end
  return [max_cell, max_power]
end

top_cell = [0,0,0]
top_power = 0
(1..298).each do |d|
  result = find_best_point(d,matrix)
  if result[1] > top_power
    top_power = result[1]
    top_cell = result[0]
  end
  p d
  p [top_cell, top_power]
end


puts max_cell
