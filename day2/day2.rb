a = []
File.open('day2.input').each_line do |line|
  a << line
end


e_twice = 0
e_triple = 0

a.each do |item|
  w_hash = {}
  item.chars do |letter|
    if w_hash[letter]
      w_hash[letter] += 1
    else
      w_hash[letter] = 1
    end
  end
  e_twice += 1 if w_hash.has_value? 2
  e_triple += 1 if w_hash.has_value? 3
end

puts e_twice
puts e_triple

puts e_twice*e_triple
