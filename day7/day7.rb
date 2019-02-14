require 'pry-byebug'
require_relative 'worker'

a = []
File.open('day7.input').each_line do |line|
  #Step B must be finished before step X can begin.
  a << [line[5], line[-13]]
end

ALL = {}
("A".."Z").each_with_index do |letter, idx|
  ALL[letter] = { begin_when: [], trigger: [], time: 61 + idx }
end

a.each do |ins|
  ALL[ins[0]][:trigger] << ins[1]
  ALL[ins[1]][:begin_when] << ins[0]
end

final_output = []

#PART ONE
# while final_output.length < 26
#   n_letter = ALL.select { |key, hash| hash[:begin_when] == [] }
#   final_output << n_letter.first[0]
#   ALL.delete(n_letter.first[0])
#   ALL.each do |key, hash|
#     hash[:begin_when].delete(n_letter.first[0])
#     hash[:trigger].delete(n_letter.first[0])
#   end
# end

#PART ONE ANSWER
# p final_output.join("")


# p ALL

WORKERS = []
("a".."e").each { |worker| WORKERS << Worker.new(worker)}

# p workers
def worker_not_done
  timer = 0
  WORKERS.each {|worker| timer += worker.time}
  return timer != 0
end

def time_past_one
  WORKERS.each do |worker|
    worker.time += 1 if worker.time < 0
    worker.available = true if worker.time == 0
    if worker.time == 0 && worker.assigned != nil
      ALL.each do |key, hash|
        hash[:begin_when].delete(worker.assigned)
      end
      worker.assigned = nil
    end
  end
end

time = 0
while final_output.length < 26 || worker_not_done || time == 0
  n_letter = ALL.select { |key, hash| hash[:begin_when] == [] }
  WORKERS.each do |worker|
    if worker.available && n_letter.length != 0
      worker.time -= n_letter.first[1][:time]
      worker.available = false
      worker.assigned = n_letter.first[0]
      final_output << n_letter.first[0]
      ALL.delete(n_letter.first[0])
      n_letter.delete(n_letter.first[0])
    end
  end
  time += 1
  time_past_one
  # p final_output
  # p time
  # WORKERS.each { |worker| puts worker}
end

#PART TWO ANSWER
p time


