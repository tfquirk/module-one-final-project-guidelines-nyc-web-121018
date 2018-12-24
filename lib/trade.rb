class Trade < ActiveRecord::Base

  belongs_to :stock
  belongs_to :investor
  has_many :account, through: :investor


  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  # def valid?(trade)
  #   #check funds available # check shares available # check trade not completed
  #
  #   if trade.num_shares * Stock.find(trade.stock_id).quote > Account.find_by(investor: trade.investor_id).balance
  #     return false
  #   end
  #
  #   if self.status != "pending"
  #     return false
  #   end
  #
  #   if Stock.all.find_by(id: trade.stock_id).shares_available < trade.num_shares
  #     return false
  #   end
  #
  #   return true
  #
  # end

  # def buy_stock(symbol)   NEED TO FIX
  #   quote = Stock.stock_quote(symbol)
  #   puts "\nYour stock is currently trading at $#{quote.delayed_price} per share."
  #   puts "You can currently afford #{(self.balance / quote.delayed_price).round(2)} share(s)"
  #   puts  "\nHow many shares would you like to buy? "
  #   answer = gets.chomp
  #   stock = Stock.find_or_create_stock_from_quote(quote)
  #   new_trade = Trade.create(status: "pending", num_shares: answer, stock_id: stock.id, investor_id: self.id)
  #   if valid?(new_trade)
  #     new_trade.stock_price = stock.delayed_price
  #     new_trade.purchase_price = stock.delayed_price * new_trade.num_shares
  #     new_trade.date = Date.today
  #     self.debit_funds(new_trade.purchase_price)
  #     new_trade.bought_sold = "bought"
  #     new_trade.status = "completed"
  #     new_trade.save
  #     puts "Your trade has been completed and your account has been debited $#{new_trade.purchase_price}"
  #   else
  #      puts "Your trade is not valid. Please check your bank account balance and/or the number of available shares for trade."
  #   end

    #check if .valid?
    #completed trade if valid and debit account
    #if not valid or cannot find stock error message and return to options

  # end

  def sell_stock(user)
    quote = Stock.stock_quote(Stock.all.find(self.stock_id).symbol).delayed_price
    sell_trade = Trade.create(status: "pending", investor_id: user.id, num_shares: self.num_shares,
      stock_price: quote, bought_sold: "In progress", stock_id: self.stock_id, date: Date.today)
    sell_trade.purchase_price = quote * sell_trade.num_shares
    user.deposit_funds(sell_trade.purchase_price)
    original_order = Trade.all.find(self.id)
    original_order.bought_sold = "sold"
    original_order.save
    binding.pry
    sell_trade.bought_sold = "sell order"
    sell_trade.status = "completed"
    sell_trade.save
    puts "\nCongratulations! You have successfully sold #{self.num_shares} of #{Stock.stock_quote(Stock.all.find(self.stock_id).company}"
  end

end # end Trade class
