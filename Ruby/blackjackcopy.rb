# coding: utf-8
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


class Card
  def initialize
    @number = rand( 13 ) + 1
    @symbol = ["♠", "♣", "♦", "♥"]
    @type = @symbol[rand(4)]
    @name
    if @number == 1
      @name = 'A'
    elsif @number.equal? 11
      @name = 'J'
    elsif @number.equal? 12
      @name = 'Q'
    elsif @number.equal? 13
      @name = 'K'
    else @name = ''+@number.to_s
    end
    if @number > 10
      @number = 10
    end
  end

  def number()
    @number
  end
  def name()
    @name
  end
  def type()
    @type
  end
  def printCard()
    if type == '♦' or type == '♥'
      print "#{@name}#{@type} ".red
    else
      print "#{@name}#{@type} "
    end
  end
end


class Player
  def initialize
    @cards = [Card.new, Card.new]
    @sum = 0
  end
  def hit()
    @cards.push(Card.new)
  end
  def listCards()
    @cards.each{ |card| card.printCard() }
  end
  def evaluate()
    @sum = 0
    @cards.each{|card| @sum += card.number}
    if @sum <= (21 - 10)
      tempCardArr = []
      loop do #the equivalent of a do-while loop
        card = @cards.pop
        unless card.nil?
          tempCardArr.push(card)
        end
        if card != nil and card.number == 1
          @sum += 10
          card = nil
          next
        end
        break if card.nil? #card points to nil
      end
      @cards = tempCardArr
    end
    @sum
  end
  def dealer()
    while evaluate < 17 do # The dealer must draw cards until
      hit()                # the sum adds up to 17 or more.
    end
  end
end



puts "\nNew game started."
player = Player.new
dealer = Player.new
dealer.dealer

hit = "y"
while hit == "y" do
  puts "Your hand:"
  print "\n| "
  player.listCards
  puts "|\n\n"
  puts "Hit? (y/n)"
  hit = gets.chomp #"gets" reads from keyboard, "chomp" removes newline
  hit.downcase
  next if hit == "n" #"next" breaks out of loop
  player.hit
end

puts "Dealer's hand:"
print "\n| "
dealer.listCards
puts "|\n\n"

puts "Your score: #{player.evaluate} Dealer's score: #{dealer.evaluate}"
if player.evaluate > dealer.evaluate and player.evaluate <= 21
  puts "You win!"
elsif dealer.evaluate > 21
  puts "Dealer busted. You win!"
elsif dealer.evaluate == player.evaluate
  puts "It's a draw!"
elsif player.evaluate > 21
  puts "Busted. You lose."
else
  puts "Dealer wins."
end
