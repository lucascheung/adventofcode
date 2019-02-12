require 'pry-byebug'
require_relative 'track'
require_relative 'cart'

carts = []
matrix = {}
cart_num = 1
File.open('day13.input').each_line.with_index do |line, y_idx|
  matrix[y_idx] = {}
  line.chars.each_with_index do |point, x_idx|
    if point.match(/[v^<>]/)
      carts << Cart.new({ name: cart_num, direction: point, x: x_idx, y: y_idx })
      cart_num += 1
    end
    matrix[y_idx][x_idx] = Track.new({ block: point, x: x_idx, y: y_idx })
    # puts matrix[y_idx][x_idx]
  end
end

crash = false
tick = 0

# binding.pry
#PART 1
# until crash
#   carts.sort_by { |first| first.y * 10000 + first.x }
#   carts.each do |cart|
#     matrix[cart.y][cart.x].state = 0
#     cart.move
#     c_block = matrix[cart.y][cart.x].block
#     cart.corner(c_block) if c_block == "\\" || c_block == "/"
#     cart.turn if c_block == '+'
#     if matrix[cart.y][cart.x].state != 0
#       crash = true
#       p [cart.x, cart.y]
#     end
#     matrix[cart.y][cart.x].state = cart.name
#   end
#   tick += 1
# end

# PART 2
# binding.pry
until carts.length == 1
  carts.sort_by! { |first| first.y * 10000 + first.x }
  carts.each do |cart|
    matrix[cart.y][cart.x].state = 0
    cart.move
    c_block = matrix[cart.y][cart.x].block
    cart.corner(c_block) if c_block == "\\" || c_block == "/"
    cart.turn if c_block == '+'
    if matrix[cart.y][cart.x].state != 0
      p [cart.x, cart.y]
      carts.delete_if { |car| car.name == matrix[cart.y][cart.x].state }
      matrix[cart.y][cart.x].state = 0
      carts.delete(cart)
    else
      matrix[cart.y][cart.x].state = cart.name
    end
  end
  tick += 1
end
puts carts[0]
