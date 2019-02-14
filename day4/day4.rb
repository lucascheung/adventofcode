a = []
File.open('day4.input').each_line do |line|
  # [1518-09-22 23:50] Guard #2309 begins shift
  a << line.delete("\n")
end

def date_fix(l)
  date = Time.new(l[0], l[1], l[2], l[3], l[4])
  date += 60 * 60 * 24 if date.hour == 23
  return date
end

a.sort!
pattern_duty = /\[\d{4}-(\d{2})-(\d{2})\s(\d{2}):(\d{2})\]\sGuard\s\#(\d+)/

duty = {}
id_minute = {}
a.map do |item|
  l = item.match(pattern_duty)
  unless l.nil?
    date = date_fix(l)
    duty[date.strftime('%m-%d')] = l[5]
    id_minute[l[5].to_i] = 0
  end
end

events = {}
pattern_falls = /\[\d{4}-(\d{2})-(\d{2})\s(\d{2}):(\d{2})\]\s(falls|wakes)/
a.map do |item|
  l = item.match(pattern_falls)
  unless l.nil?
    date = date_fix(l)
    minute = l[4]
    sleeps = l[5] == 'falls'
    if events[date.strftime('%m-%d')].nil?
      events[date.strftime('%m-%d')] = { minute.to_i => sleeps }
    else
      events[date.strftime('%m-%d')][minute.to_i] = sleeps
    end
  end
end

events.each do |day, value|
  sum = 0
  value.each do |minute, sleep|
    sum -= minute.to_i if sleep
    sum += minute.to_i if !sleep
  end
  id_minute[duty[day].to_i] += sum
end

minute = {}
(0..59).each do |min|
  minute[min] = 0
end

#   minute[min] += 1 if sleeps == true
# end
part_one = events.select {|k, v| duty[k] == id_minute.key(id_minute.values.max).to_s}
# p events

part_one.each do |k, v|
  count = 0
  asleep = false
  while count < 60
    asleep = v[count] unless v[count].nil?
    minute[count] += 1 if asleep == true
    count += 1
  end
  # p minute
end

# part 1 answer
# p id_minute.key(id_minute.values.max) * minute.key(minute.values.max)

# p id_minute

# p duty

all_minute = {}
id_minute.each_key do |guard_id|
  part_two = events.select {|k, v| duty[k] == guard_id.to_s}
  minute = {}
  (0..59).each do |min|
    minute[min] = 0
  end
  part_two.each do |k, v|
    count = 0
    asleep = false
    while count < 60
      asleep = v[count] unless v[count].nil?
      minute[count] += 1 if asleep == true
      count += 1
    end
  end
  # p minute.key(minute.values.max)
  all_minute[guard_id] = {themin: minute.key(minute.values.max), freq: minute.values.max}
end
# p all_minute
p all_minute.max_by { |k, v| v[:freq]}
# p all_minute.key(all_minute.values[1].max)
# p all_minute.values.max





















