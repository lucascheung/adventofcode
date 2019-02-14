a = []
File.open('day2.input').each_line do |line|
  a << line
end

a.each {|e| e.gsub!("\n","")}

done = true

while done
  (0..a.length).each do |idx1|
    (idx1+1...a.length).each do |idx2|
      pos = 0
      count = 0
      while count < 2
        if a[idx1][pos] != a[idx2][pos]
          count += 1
          pos+=1
        elsif pos == 25
          puts a[idx1], a[idx2]
          done = false
          break
        else
          pos+=1
        end
      end
    end
  end
end
