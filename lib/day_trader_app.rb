
def welcome
  puts "Hello, welcome to DayTrader. Please sign in with your name (first + last): "
end

def user_imput
  gets.chomp
end

def options
  puts "\n\nWhat would you like to do?"
  puts "\t 1. Research"
  puts "\t 2. Buy stock"
  puts "\t 3. Sell stock"
  puts "\t 4. Review portfolio"
  puts "\t 5. My bank account balance"
  puts "\t 6. Signout"
end

def login(username)
  first_name = username.split(" ").first
  if !Investor.all.find_by(name: username)
    puts "\n\nYou do not currently have an account, #{first_name}. Please fill in your information to create one:"
    user = create_new_user(username)
    create_new_bank_account(user)
    options
  else
    options
  end
end

  def create_new_user(username)
    new_user = Investor.new
    new_user.name = username
    first_name = username.split(" ").first
    puts "\nWhat is your age, #{first_name}?"
    response1 = gets.chomp
    new_user.age = response1

    puts "\nWhat is your address, #{first_name}?"
    response2 = gets.chomp
    new_user.address = response2

    puts "\nWhat city do you live in, #{first_name}?"
    response3 = gets.chomp
    new_user.city = response3

    puts "\nWhat state do you live in, #{first_name}? ex. GA, or CA"
    response4 = gets.chomp
    new_user.state = response4

    puts "\nWhat is your email address, #{first_name}?"
    response5 = gets.chomp
    new_user.email = response5

    puts "\nWhat is your phone number, #{first_name}?"
    response6 = gets.chomp
    new_user.phone_num = response6
    new_user.save

    puts "\n\nThanks, #{first_name}. Your account has been created. \n\n"

    Investor.find_by(name: username)
  end

  def create_new_bank_account(investor)
    new_investor = Account.create(balance: rand(500..20000), investor_id: investor.id, bank_id: rand(6))
    puts "."
    puts "."
    puts "."
    puts "."
    puts "."
    puts "."
    puts "------- We have linked your bank account.\n"
    puts "------- You currently have $#{new_investor.balance} in your account available immediately."
  end
