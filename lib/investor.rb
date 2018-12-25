class Investor < ActiveRecord::Base

  has_many :trade
  has_many :stock, through: :trade
  has_many :account

  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  def balance
    account = Account.find_by(investor_id: self.id)
    account.balance.round(2)
  end

  def my_stocks
    trades = Trade.all.select {|trade| trade.investor_id == self.id} #select my trades
    not_sold = trades.select {|trade| trade.bought_sold == "bought"} #select stocks I've bought, but not yet sold
  end

  def print_my_stocks
    my_stocks.each do |stock| #print out stocks to screen
        puts "\n#{Stock.all.find(stock.stock_id).company}"
        puts "\tShares: #{stock.num_shares}"
        puts "\tPurchased for: $#{stock.purchase_price}\n"
        puts "\tStock ID: #{stock.stock_id}\n"
      end
  end

  def my_stocks_analysis
    my_stocks.each do |stock| #print out stocks to screen
        puts "\n#{Stock.all.find(stock.stock_id).company}"
        puts "\tShares: #{stock.num_shares}"
        puts "\tPurchased for: $#{stock.purchase_price.round(2)}"
        current_quote = IEX::Resources::Quote.get(Stock.find(stock.stock_id).symbol).delayed_price
        puts "\tCurrent quote: $#{current_quote.round(2)} per share"
        puts "\tCurrent value: $#{current_quote * stock.num_shares.round(2)}"
        if stock.purchase_price > current_quote * stock.num_shares
          puts "\tPercent change: -#{((stock.purchase_price - (current_quote * stock.num_shares)) / stock.purchase_price * 100).round(2)}%"
        else
          puts "\tPercent change: +#{((current_quote * stock.num_shares - (stock.purchase_price)) / stock.purchase_price * 100).round(2)}%\n"
        end
    end
  end

  def deposit_funds(amount)
    account = Account.find_by(investor_id: self.id)
    account.balance += amount
    account.save
    puts "\n\nYour account balance is now: $#{account.balance}"
  end

  def debit_funds(amount)
    account = Account.find_by(investor_id: self.id)
    account.balance -= amount
    account.save
    puts "\n\nYour account balance is now: $#{account.balance}"
  end

end # end Investor class
