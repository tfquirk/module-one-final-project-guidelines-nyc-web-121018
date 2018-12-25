class Trade < ActiveRecord::Base

  belongs_to :stock
  belongs_to :investor
  has_many :account, through: :investor


  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  def funds_available?
    #check if users has appropriate funds available to purchase num_shares of stock
    if self.num_shares * Stock.find(self.stock_id).quote > Account.find_by(investor_id: self.investor_id).balance
      self.status = "canceled"
      self.bought_sold = "Funds to execute trade were unavailable."
      puts "Your account does not have the funds available to execute this trade."
      return false
    else
      true
    end

  end
  # def valid?(trade)
  #
  ## check shares available # check trade not completed
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

  def self.buy_stock(user, quote, buy_trade)
    if buy_trade.funds_available?
      buy_trade.purchase_price = quote.delayed_price * buy_trade.num_shares
      user.debit_funds(buy_trade.purchase_price)
      buy_trade.bought_sold = "bought"
      buy_trade.status = "completed"
      buy_trade.save
    end
  end

  def sell_stock(user)
    quote = Stock.stock_quote(Stock.all.find(self.stock_id).symbol).delayed_price
    sell_trade = Trade.create(status: "pending", investor_id: user.id, num_shares: self.num_shares,
      stock_price: quote, bought_sold: "In progress", stock_id: self.stock_id, date: Date.today)
    sell_trade.purchase_price = quote * sell_trade.num_shares
    user.deposit_funds(sell_trade.purchase_price)
    original_order = Trade.all.find(self.id)
    original_order.bought_sold = "sold"
    original_order.save
    sell_trade.bought_sold = "sell order"
    sell_trade.status = "completed"
    sell_trade.save
  end

  def weekend?(date)
    if Date.today == Date.today.saturday? || Date.today == Date.today.sunday?
      puts "Sorry no trades can be made over the weekend"
      options(self)
    else
      return false
    end
  end

end # end Trade class
