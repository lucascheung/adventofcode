a = {}
File.open('day3.input').each_line do |line|
  num = line.split(/\W/)
  a[num[1].to_i] = [num[4].to_i, num[5].to_i, num[7].split('x')[0].to_i, num[7].split('x')[1].to_i]
end

matrix = Hash.new(0)

#part 1
a.each do |_key, value|
  (1..value[2]).each do |width|
    (1..value[3]).each do |height|
      matrix[value[0] + value[1] * 1000 + width + height * 1000] += 1
    end
  end
end

puts matrix.select { |_k, v| v > 1 }.length

a.each do |key, value|
  jj = true
  inch = 0
  while inch <= value[2] * value[3] && jj == true
    (1..value[2]).each do |width|
      break if jj == false

      (1..value[3]).each do |height|
        break if jj == false

        if matrix[value[0] + value[1] * 1000 + width + height * 1000] > 1
          jj = false
        elsif inch == value[2] * value[3]
          puts key
          jj = false
        else
          inch += 1
        end
      end
    end
  end
end
