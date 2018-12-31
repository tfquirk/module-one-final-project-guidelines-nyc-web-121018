class Trade < ActiveRecord::Base

  belongs_to :stock
  belongs_to :investor
  has_many :account, through: :investor

  # allows user to buy a new stock and creates a record of it in the trade class
  def self.buy_stock(user, quote, buy_trade)
    if buy_trade.funds_available?
      buy_trade.purchase_price = quote.delayed_price * buy_trade.num_shares
      user.debit_funds(buy_trade.purchase_price)
      buy_trade.bought_sold = "bought"
      buy_trade.status = "completed"
      buy_trade.save
      puts "\nCongratulations! You have successfully bought #{buy_trade.num_shares}"
      puts " shares of #{quote.company_name}"

    end
  end

  def self.sell_all_stocks(user)
    user.my_stocks.each do |trade|
      trade.sell_stock(user)
    end

    puts "All of your stocks have been sold."
  end

  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  #check if users has appropriate funds available to purchase num_shares of stock
  def funds_available?
    if self.num_shares * Stock.find(self.stock_id).quote > Account.find_by(investor_id: self.investor_id).balance
      self.status = "canceled"
      self.bought_sold = "Funds to execute trade were unavailable."
      puts "Your account does not have the funds available to execute this trade."
      return false
    else
      true
    end
  end

  #makes sure the number of shares you are looking to purchase are available
  def shares_available_for_purchase?
    if Stock.all.find_by(id: trade.stock_id).shares_available < trade.num_shares
      return false
    else
      return true
    end
  end

  #checks transaction status, and verifies it has not already been completed
  def transaction_already_completed?
    if self.status != "pending"
      return false
    else
      true
    end
  end

  # gets a new stock price quote, and process the trade
  def sell_stock(user)
    quote = Stock.stock_quote(Stock.all.find(self.stock_id).symbol)
    sell_trade = Trade.create(status: "pending", investor_id: user.id, num_shares: self.num_shares,
      stock_price: quote.delayed_price, bought_sold: "In progress", stock_id: self.stock_id, date: Date.today)
    sell_trade.purchase_price = quote.delayed_price * sell_trade.num_shares
    user.deposit_funds(sell_trade.purchase_price)
    original_order = Trade.all.find(self.id)
    original_order.bought_sold = "sold"
    original_order.save
    sell_trade.bought_sold = "sell order"
    sell_trade.status = "completed"
    sell_trade.save
    puts "\nCongratulations! You have successfully sold #{sell_trade.num_shares} shares of #{quote.company_name}"
  end

  def sell_partial_stock(user, shares_to_sell)
    quote = Stock.stock_quote(Stock.all.find(self.stock_id).symbol)
    sell_trade = Trade.create(status: "pending", investor_id: user.id, num_shares: shares_to_sell,
      stock_price: quote.delayed_price, bought_sold: "In progress", stock_id: self.stock_id, date: Date.today)
    sell_trade.purchase_price = quote.delayed_price * sell_trade.num_shares
    user.deposit_funds(sell_trade.purchase_price)
    original_order = Trade.all.find(self.id)
    original_order.purchase_price = original_order.stock_price * (original_order.num_shares - shares_to_sell)
    original_order.num_shares -= shares_to_sell
    original_order.save
    sell_trade.bought_sold = "partial sell order from trade ID: #{self.id}"
    sell_trade.status = "completed"
    sell_trade.save
    puts "\nCongratulations! You have successfully sold #{sell_trade.num_shares} shares of #{quote.company_name}"
  end

  #this method is not used, but was create with the option to expand functionality in the future
  # def weekend?(date)
  #   if Date.today == Date.today.saturday? || Date.today == Date.today.sunday?
  #     puts "Sorry no trades can be made over the weekend"
  #     options(self)
  #   else
  #     return false
  #   end
  # end

end # end Trade class
