
# --------------------- Determine user & create new user if they do not exist

  def login(username) #username is a full name (first and last) string
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

  def create_new_user(username) #only called when username does not exist in DB
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

  def create_new_bank_account(investor)    #called when user created or user needs a bank account associated
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

# --------------------- end determine user ------------------------
# --------------------- user helper methods -----------------------

  def user_imput
    gets.chomp
  end

  def call_options(user)
    options(user)
  end

  def user_first_name(user)
    user.name.split(" ").first
  end

# --------------------- end user helper methods -------------------
# --------------------- start DayTrader fuctionality --------------


  def welcome
    puts "\nHello, welcome to DayTrader. Please sign in with your name (first + last): "
  end

  # primary account menu
  def options(user)
    puts "***********************************************************\n"
    puts "\n\nWhat would you like to do, #{user_first_name(user)}?"
    puts "\t 1. My bank account balance"
    puts "\t 2. Review portfolio/analysis"
    puts "\t 3. Research"
    puts "\t 4. Buy stock"
    puts "\t 5. Sell stock"
    puts "\t 6. User settings"
    puts "\t 7. Signout"

    input = gets.chomp

    case input
    when "1"
      if !Account.find_by(investor_id: user.id)   # if user does not have a linked bank account this condition will run
        puts "***********************************************************"
        puts "\n\nYour bank account must be linked to retrieve your balance."
        puts "Would you like to link your bank account? (Y/N)"
        answer = user_imput.downcase

        case answer
        when 'y'
          create_new_bank_account(user)
          call_options(user)
        when 'n'
          puts "You are not able to purchase stock at this time. "
          call_options(user)
        else
          puts "Invalid input. Returning you to the main menu."
          sleep(2)
          call_options(user)
        end
      else     # else bank account balance is returned
        puts "\n\n#{user_first_name(user)}, your current balance is:     $#{user.balance}"
        call_options(user)
      end
    when "2"   # Finds all stocks owned by a user, and returns them (if any) with analysis
      puts "\n\n#{user_first_name(user)}, here are the current stocks you own: "
      user.my_stocks_analysis
      sleep(3)
      options(user)
    when "3"    # allows user to research any stock symbol. Calls IEX API
      puts "\nWhich stock would you like to research? (stock symbol)"
      answer = gets.chomp
      quote = Stock.stock_quote(answer)
      Stock.research_quote(quote, user)
      sleep(4)
      call_options(user)
    when "4"
      if !Account.find_by(investor_id: user.id)      #if user does not have linked bank account then this condition is called
        puts "You must link a bank account to buy stocks."
        puts "Would you like to link your bank account? (Y/N)"
        answer = user_imput.downcase

        case answer
        when 'y'
          create_new_bank_account(user)
          call_options(user)
        when 'n'
          puts "You are not able to purchase stock at this time. "
          call_options(user)
        else
          puts "Invalid input. Please pick Y or N."
          sleep(2)
          call_options(user)
        end
      else         # else user buys a stock
        puts "\nWhich stock would you like to purchase? (stock symbol)"
        answer = gets.chomp
        quote = Stock.stock_quote(answer)
        puts "\nHow many shares would you like to purchase? (number)"
        number = gets.chomp
        stock = Stock.find_or_create_stock_from_quote(quote)
        new_trade = Trade.create(status: "pending", investor_id: user.id, num_shares: number,
          stock_price: quote.delayed_price, bought_sold: "In progress", stock_id: stock.id, date: Date.today)
        Trade.buy_stock(user, quote, new_trade)
        call_options(user)
      end
    when "5"
      if !Account.find_by(investor_id: user.id)      #if user does not have linked bank account then this condition is called
        puts "You must link a bank account to buy stocks."
        puts "You must link a bank account to sell stocks."
        puts "Would you like to link your bank account? (Y/N)"
        answer = user_imput.downcase

        case answer
        when 'y'
          create_new_bank_account(user)
          call_options(user)
        when 'n'
          puts "You are not able to purchase stock at this time. "
          call_options(user)
        else
          puts "Invalid input. Please pick Y or N."
          sleep(2)
          call_options(user)
        end
      else         # else user can sell all shares or partial shares of a given stock
        sleep(0.8)
        puts "."
        sleep(0.8)
        puts "."
        sleep(0.8)
        puts "."
        puts "\n\n#{user_first_name(user)}, you currently own: \n"
        user.print_my_stocks
        puts "\nWhich stock would you like to sell? (Stock ID)"
        answer = gets.chomp.to_i
        trade = Trade.all.find_by(stock_id: answer, investor_id: user.id)
        puts "\nHow many shares would you like to sell? (Number)"
        number = gets.chomp.to_i
        if number < trade.num_shares
          trade.sell_partial_stock(user, number)
        else
          trade.sell_stock(user)
        end
        call_options(user)
      end
    when "6"     # user may call menu_settings which relates to information about their account
      menu_settings(user)
    when "7"     # exits the program
      puts "\n\nThank you. Have a great day!\n\n"

    else      # if a user does not input an appropriate number, they are returned to the same main menu
      puts "Invalid input. Please pick a number from this list."
      sleep(2)
      call_options(user)
    end
  end

  def menu_settings(user)     # menu for User settings from main menu
    puts "\n\nThank you, #{user_first_name(user)}, please select from the following options: "
    puts "\t 1. Update user info"
    puts "\t 2. Close bank account"
    puts "\t 3. Return to main menu"

    new_menu = gets.chomp
    case new_menu
    when "1"   # called to allow user to update information relevant to their account (address, email, etc.)
      update_account(user)
    when "2"   # allows user to unlink their bank account (this destroys bank account info)
      if !Account.find_by(investor_id: user.id)
        puts "Your account has already been closed."
        call_options(user)
      else
        close_bank_account(user)
      end
    when "3"    # returns to main menu (options)
      call_options(user)
    else
      puts "Invalid input. Please pick a number from this list."
      sleep(2)
      menu_settings(user)
    end

  end

  def update_account(user)     # allows user to update account specifics
    puts "***********************************************************\n"
    puts "\n\nThank you, #{user_first_name(user)}, please select from the following options: "
    puts "\t 1. Update username"
    puts "\t 2. Update age"
    puts "\t 3. Update address"
    puts "\t 4. Update email"
    puts "\t 5. Update phone number"
    puts "\t 6. Return to main menu"

    update = user_imput

    case update
    when "1"     # User cannot update username themself -- for security purposes
      puts "\n\nThank you, #{user_first_name(user)}, to update your username please "
      puts "contact our customer service department by phone. "
      puts "\tPhone number: 1-800-DAY-TRADE"
      update_account(user)
    when '2'     # update age
      puts "\nWhat is your age, #{user_first_name(user)}?"
      response1 = user_imput
      user.age = response1
      user.save
      update_account(user)
    when '3'     # update address, city, state
      puts "\nWhat is your address, #{user_first_name(user)}?"
      response2 = user_imput
      user.address = response2

      puts "\nWhat city do you live in, #{user_first_name(user)}?"
      response3 = user_imput
      user.city = response3

      puts "\nWhat state do you live in, #{user_first_name(user)}? ex. GA, or CA"
      response4 = user_imput
      user.state = response4
      user.save
      update_account(user)
    when '4'     # update email
      puts "\nWhat is your email address, #{user_first_name(user)}?"
      response5 = user_imput
      user.email = response5
      user.save
      update_account(user)
    when '5'     # update phone number
      puts "\nWhat is your phone number, #{user_first_name(user)}?"
      response6 = user_imput
      user.phone_num = response6
      user.save
      update_account(user)
    when '6'     # return to main menu
      call_options(user)
    else      # force user to pick from current menu
      puts "Invalid input. Please pick a number from this list."
      sleep(2)
      menu_settings(user)
    end
  end

  def close_bank_account(user)     # destroys bank account, sells all current stocks, and user cannot buy/sell stock until new bank account linked
    puts "***********************************************************\n"
    puts "If you close your bank account with us, you will "
    puts "no longer be able to place any stock trades.  "
    puts "\nYou MUST sell all current stocks before closing this account. "
    puts "\nSelecting Y will ATOMATICALLY sell all of your stocks. "
    puts "Are you sure you want to continue? (Y/N) "

    delete_account = user_imput.downcase

    if delete_account == 'y'      # destroys bank account and sells all stocks
      user_account = Account.find_by(investor_id: user.id)
      Trade.sell_all_stocks(user)
      user_account.destroy

      puts "Your account information has been removed from our system."
      call_options(user)
    elsif delete_account == 'n'   # returns user to main menu
      call_options(user)
    else        # forces user to use current menu options
      puts "Invalid input. Please pick Y or N."
      sleep(2)
      close_bank_account(user)
    end

  end

# --------------------- end DayTrader fuctionality ----------------
