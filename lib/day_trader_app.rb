
def welcome
  puts "Hello, welcome to DayTrader. Please sign in with your name: "
end

def user_imput
  gets.chomp
end

def options
  puts "What would you like to do?"
  puts "\t 1. Research"
  puts "\t 2. Buy stock"
  puts "\t 3. Sell stock"
  puts "\t 4. Review portfolio"
  puts "\t 5. Signout"
end
