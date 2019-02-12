require "pry-byebug"
a = []
File.open('day1.input').each_line do |line|
  a << line.to_i
end

record = [0]
b = 0
dup_found = false
until dup_found
  a.each do |number|
    b += number.to_i
    if record.include? b
      puts "Part 2: "
      puts b
      dup_found = true
    else
      record << b
    end
  end
end
