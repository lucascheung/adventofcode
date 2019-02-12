require 'csv'
require 'pry-byebug'
require_relative 'star'

a = []

File.open('day10.input').each_line do |line|
  star = Star.new(*line.scan(/\W\d+/).map(&:to_i))
  a << star
end

seconds = 1
closest = false

pre_max = 200000
while seconds < 15000 && closest == false
  a.each do |star|
    star.x += star.x_v
    star.y += star.y_v
  end
  max = a.max_by { |star| star.y.abs }.y
  if max > pre_max
    closest = true
    puts seconds - 1
    a.each do |star|
      star.x -= star.x_v
      star.y -= star.y_v
    end
  else
    seconds += 1
    pre_max = max
  end
end

canvas = {}


(-180..180).each do |y|
  canvas[y] = {}
  (180..300).each do |x|
    canvas[y][x] = "."
  end
end

a.each do |star|
  canvas[star.y][star.x] = "#"
end


final= []

canvas.map do |y,x|
  final << x.values.join("")
  # puts final
end

csv_op = { col_sep: '', force_quotes: false,  }
afile = File.open('day10.txt','r+')
final.each do |line|
  afile.syswrite(line)
  afile.syswrite("\n")
end





# p canvas[0]
