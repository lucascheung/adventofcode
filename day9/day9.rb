require 'pry-byebug'
players = {}

(0..426).each { |num| players[num] = 0 }
# (0..21).each { |num| players[num] = 0 }

# p players

count = 1
array = [0]
pre_pos = 0
player = 1

while count <= 72058
# while count <= 6111
  player = 1 if player == 427
  # player = 1 if player == 22
  if count % 23 != 0
    if pre_pos + 2 < array.length
      array.insert(pre_pos + 2, count)
      pre_pos += 2
    elsif pre_pos + 2 == array.length
      array << count
      pre_pos += 2
    else
      array.insert(1, count)
      pre_pos = 1
    end
  else
    players[player] += count
    the_pos = pre_pos - 7
    players[player] += array[the_pos]
    array.delete_at(the_pos)
    pre_pos = the_pos >= 0 ? the_pos : array.length - the_pos
  end
  player += 1
  count += 1
  # p count if count % 100 == 0
  # p [count -1 , pre_pos, player - 1]
  # p players
  # p array
  # binding.pry
end

p players.max_by { |_k, v| v }
# p players
