require 'pry-byebug'
require_relative 'marble'
players = {}
(1..426).each { |num| players[num] = 0 }

original = Marble.new(0)

current_marble = original
previous_marble = original
next_marble = original

current_marble.previous = previous_marble
current_marble.next = next_marble
previous_marble.next = current_marble
previous_marble.previous = next_marble
next_marble.next = previous_marble
next_marble.previous = current_marble

def linking(current_marble, previous_marble, next_marble)
  current_marble.previous = previous_marble
  current_marble.next = next_marble
  previous_marble.next = current_marble
  next_marble.previous = current_marble
end

count = 1
player = 1
while count <= 7205800
  player = 1 if player > 426
  new_marble = Marble.new(count)
  if count % 23 == 0
    previous_marble = current_marble.previous.previous.previous.previous.previous.previous.previous.previous
    next_marble = previous_marble.next.next.next
    current_marble = previous_marble.next.next
    players[player] += previous_marble.next.number + new_marble.number
  else
    previous_marble = next_marble
    next_marble = next_marble.next
    current_marble = new_marble
  end
  linking(current_marble, previous_marble, next_marble)
  count += 1
  player += 1
  # binding.pry
end

p players.max_by{|k, v| v }
