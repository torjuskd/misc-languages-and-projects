
=begin
This is a multiline comment and con spwan as many lines as you
like. But =begin and =end should come in the first line only. 
=end

#line comment

# class String
#   # colorization
#   def colorize(color_code)
#     "\e[#{color_code}m#{self}\e[0m"
#   end

#   def red
#     colorize(31)
#   end

#   def green
#     colorize(32)
#   end

#   def yellow
#     colorize(33)
#   end

#   def pink
#     colorize(35)
#   end
# end

class String
def black;          "\033[30m#{self}\033[0m" end
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def blue;           "\033[34m#{self}\033[0m" end
def magenta;        "\033[35m#{self}\033[0m" end
def cyan;           "\033[36m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bg_black;       "\033[40m#{self}\033[0m" end
def bg_red;         "\033[41m#{self}\033[0m" end
def bg_green;       "\033[42m#{self}\033[0m" end
def bg_brown;       "\033[43m#{self}\033[0m" end
def bg_blue;        "\033[44m#{self}\033[0m" end
def bg_magenta;     "\033[45m#{self}\033[0m" end
def bg_cyan;        "\033[46m#{self}\033[0m" end
def bg_gray;        "\033[47m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
def reverse_color;  "\033[7m#{self}\033[27m" end
end

puts "I'm back green".bg_green
puts "I'm red and back cyan".red.bg_cyan
puts "I'm bold and green and backround red".bold.green.bg_red

print "Hello world!";

['toast', 'cheese', 'wine'].each { |food| print food.capitalize }



puts "hello world".bg_red.black
