require 'pry-byebug'
a = ''
File.open('day5.input').each_line do |line|
  # [1518-09-22 23:50] Guard #2309 begins shift
  a += line.delete("\n")
end

pattern = /Aa|Bb|Cc|Dd|Ee|Ff|Gg|Hh|Ii|Jj|Kk|Ll|Mm|Nn|Oo|Pp|Qq|Rr|Ss|Tt|Uu|Vv|Ww|Xx|Yy|Zz|aA|bB|cC|dD|eE|fF|gG|hH|iI|jJ|kK|lL|mM|nN|oO|pP|qQ|rR|sS|tT|uU|vV|wW|xX|yY|zZ|/
pattern_s = 'Aa|Bb|Cc|Dd|Ee|Ff|Gg|Hh|Ii|Jj|Kk|Ll|Mm|Nn|Oo|Pp|Qq|Rr|Ss|Tt|Uu|Vv|Ww|Xx|Yy|Zz|aA|bB|cC|dD|eE|fF|gG|hH|iI|jJ|kK|lL|mM|nN|oO|pP|qQ|rR|sS|tT|uU|vV|wW|xX|yY|zZ|'

def findlength(string, pattern)
  length = 0
  while string.length != length
    length = string.length
    string.gsub!(pattern, '')
  end
  return string.length
end

# p findlength(a, pattern)

shortest = 500000000000
("A".."Z").each do |letter|
  # new_s = Regexp.new "#{letter}#{(letter.bytes[0]+32).chr}\|"
  # new_r = Regexp.new "#{(letter.bytes[0]+32).chr}#{letter}\|"
  b = a.delete(letter).delete(letter.downcase)
  the_length = findlength(b, pattern)
  shortest = the_length if the_length < shortest
  p letter
end

p shortest
