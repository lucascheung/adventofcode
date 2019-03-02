require 'pry-byebug'
require_relative 'cell'

GRID = {}

#Generate GRID
(0..2000).each do |y_idx|
  GRID[y_idx] = {}
  (0..2000).each do |x_idx|
    GRID[y_idx][x_idx] = Cell.new(y: y_idx, x: x_idx, clay: false)
  end
end

highest_clay_y = 2000
lowest_clay_y = 0

#MAP ALL CLAY
File.open('day17.input').each_line do |line|
  pattern = /(\w)=(\d+), (\w)=(\d+)\.\.(\d+)/
  data = pattern.match(line)
  if data[1] == 'x'
    (data[4].to_i..data[5].to_i).each do |y_idx|
      GRID[y_idx][data[2].to_i].clay = true
      lowest_clay_y = y_idx if y_idx > lowest_clay_y
      highest_clay_y = y_idx if y_idx < highest_clay_y
    end
  else
    (data[4].to_i..data[5].to_i).each do |x_idx|
      GRID[data[2].to_i][x_idx].clay = true
      lowest_clay_y = data[2].to_i if data[2].to_i > lowest_clay_y
      highest_clay_y = data[2].to_i if data[2].to_i < highest_clay_y
    end
  end
end

puts "lowest_clay_y: #{lowest_clay_y}"


def settle?(w_end)
  current = w_end
  left = false
  right = false
  #check left
  left_running = true
  right_running = true
  while left_running
    if current.clay
      left_running = false
      left = true
    elsif !current.down.clay && current.down.water != '~'
      left_running = false
    end
    current = current.left
  end
  #check right
  current = w_end
  while right_running
    if current.clay
      right_running = false
      right = true
    elsif !current.down.clay && current.down.water != '~'
      right_running = false
    end
    current = current.right
  end
  left && right
end

def fill_up_settle_water(w_end)
  left_running = true
  right_running = true
  w_end.water = '~'
  #fill left
  current = w_end
  while left_running
    if current.clay
      left_running = false
    else
      current.water = '~'
      current = current.left
    end
  end
  #fill right
  current = w_end
  while right_running
    if current.clay
      right_running = false
    else
      current.water = '~'
      current = current.right
    end
  end
end

def fill_up_flowing_water(w_end)
  left_running = true
  right_running = true
  n_ends = []
  #fill left
  current = w_end
  while left_running
    if !current.down.clay && current.down.water != '~'
      current.water = '|'
      left_running = false
      n_ends << current
    elsif current.left.clay
      current.water = '|'
      left_running = false
    else
      current.water = '|'
      current = current.left
    end
  end

  #fill right
  current = w_end
  while right_running
    if !current.down.clay && current.down.water != '~'
      current.water = '|'
      right_running = false
      n_ends << current
    elsif current.right.clay
      current.water = '|'
      right_running = false
    else
      current.water = '|'
      current = current.right
    end
  end

  return n_ends
end

spring = GRID[0][500]
w_ends = [spring]

puts 'starts the water flow'

until w_ends.empty?
  w_ends.each do |w_end|
    # binding.pry
    if w_end.y == lowest_clay_y
      w_ends.delete(w_end)
    else
      current = w_end.down
      # binding.pry
      if !current.clay && (!current.down.clay && current.down.water == '')
        # puts "downflow #{current}"
        n_end = current
        n_end.water = '|'
        w_ends << n_end
        w_ends.delete(w_end)
      elsif !current.clay && (current.down.clay || current.down.water != '')
        # puts "block before touching clay #{current}"
        n_end = current
        if settle?(n_end)
          # puts 'filling settle water'
          fill_up_settle_water(n_end)
          w_ends.delete(w_end)
          w_ends << w_end.up
          # binding.pry
        else
          # puts 'filling flowing water'
          w_ends << fill_up_flowing_water(n_end)
          w_ends.delete(w_end)
          w_ends.flatten!
        end
      elsif current.clay
        # puts "touches clay"
        w_ends.delete(w_end)
      end
    end
  end
end

total = 0
settle = 0
(highest_clay_y..2000).each do |y_idx|
  (0..2000).each do |x_idx|
    total += 1 if GRID[y_idx][x_idx].water != ''
    settle += 1 if GRID[y_idx][x_idx].water == '~'
    # p [x_idx, y_idx, GRID[y_idx][x_idx].water] if GRID[y_idx][x_idx].water != ''
  end
end

#PART ONE
puts total


#PART TWO
puts settle



