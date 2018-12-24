
def welcome
  puts "Hello, welcome to DayTrader. Please sign in with your name (first + last): "
end

def user_imput
  gets.chomp
end

def call_options(user)
  options(user)
end

def options(user)
  puts "\n\nWhat would you like to do?"
  puts "\t 1. Review portfolio"
  puts "\t 2. Buy stock"
  puts "\t 3. Sell stock"
  puts "\t 4. Research" #strech goal
  puts "\t 5. My bank account balance"
  ### TODO: Create option to switch users?
  puts "\t 6. Signout"

  input = gets.chomp

  case input
  when "1"
    puts "\n\nThese are the current stocks you own: "
    user.print_my_stocks
    sleep(3)
    options(user)
  when "2"
    #run buy stock logic
  when "3"
    puts "\n\n#{user.name.split(" ").first}, you currently own: \n"
    user.print_my_stocks
    puts "\nWhich stock would you like to sell? (Stock ID)"
    answer = gets.chomp.to_i
    Trade.all.find_by(stock_id: answer, investor_id: user.id).sell_stock
  when "4"
    user.shares_owned
    sleep(5)
    call_options(user)
  when "5"
    puts "Your current balance is:     $#{user.balance}"
    call_options(user)
  when "6"
    puts "\n\nThank you. Have a great day!"

  else
    puts "Invalid input. Please pick a number from this list."
    sleep(2)
    call_options(user)
  end
end



def login(username)
  first_name = username.split(" ").first
  if !Investor.all.find_by(name: username)
    puts "\n\nYou do not currently have an account, #{first_name}. Please fill in your information to create one:"
    user = create_new_user(username)
    create_new_bank_account(user)
    options(user)
  else
    user = Investor.all.find_by(name: username)
    options(user)
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
    sleep(0.8)
    puts "."
    sleep(0.8)
    puts "."
    sleep(0.8)
    puts "."
    sleep(0.8)
    puts "."
    sleep(0.8)
    puts "."
    sleep(0.8)
    puts "."
    sleep(0.8)
    puts "----- We have linked your bank account.\n"
    puts "----- You currently have $#{new_investor.balance} in your account available immediately."
  end
