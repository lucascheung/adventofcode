initial = '..#..####.##..#.##.#..#.....##..#.###.#..###....##.##.#.#....#.##.####.#..##.###.#.......#............'

patterns = {}
File.open('day12.input').each_line do |line|
  a = line.chop.split(' => ')
  patterns[a[0]] = a[1]
end
sum = 0
old_gen = initial
new_gen = nil
500.times do |num|
  new_gen = '....'
  (2...old_gen.length - 2).each do |pot|
    new_gen += patterns[old_gen[pot - 2, 5]]
  end
  old_gen = new_gen + '...'
  # p old_gen[2 * num ..-1]

  final = old_gen[2 * (num + 1) ..-1]
  old_sum = sum
  sum = 0

  (0...final.length).each do |idx|
    sum += idx - 2 if final[idx] == "#"
  end
  p [num + 1, sum - old_sum, sum]
end
# p final
# p final.length
# p sum
# p patterns


#after 126 generations, sum is 3994
#then its 36 difference

first = 3994
left = 50000000000 - 126
gap = 36
total = first + left * gap

p total
