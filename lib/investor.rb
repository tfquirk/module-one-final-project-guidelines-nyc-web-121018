class Investor < ActiveRecord::Base

  has_many :trade
  has_many :stock, through: :trade
  has_many :account

  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  def balance
    account = Account.find_by(investor_id: self.id)
    account.balance
  end

  def my_stocks
    trades = Trade.all.select {|trade| trade.investor_id == self.id} #select my trades
    not_sold = trades.select {|trade| trade.bought_sold == "bought"} #select stocks I've bought, but not yet sold
  end

  def my_stocks_analysis
    my_stocks.each do |stock| #print out stocks to screen
        puts Stock.all.find(stock.stock_id).company
        puts "\tShares: #{stock.num_shares}"
        puts "\tPurchased for: $#{stock.purchase_price}"
        current_quote = IEX::Resources::Quote.get(Stock.find(stock.stock_id).symbol).delayed_price
        puts "\tCurrent quote: $#{current_quote} per share"
        puts "\tCurrent value: $#{current_quote * stock.num_shares}"
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
    puts "Your account balance is now: $#{account.balance}"
  end

  def debit_funds(amount)
    account = Account.find_by(investor_id: self.id)
    account.balance -= amount
    account.save
    puts "Your account balance is now: $#{account.balance}"
  end

  def shares_owned # returns the number of shares owned and which company
    trades = Trade.all.select {|trade| trade.investor_id == self.id if trade.bought_sold == "bought"}
    puts "\n\n#{self.name.split(" ").first}, you currently own:"
    trades.each {|trade| puts "\t#{trade.num_shares} share(s) of #{Stock.all.find(trade.stock_id).company}"}
  end

  def stock_quote(symbol)
    new_quote = IEX::Resources::Quote.get(symbol)
    if !Stock.all.find_by(company: new_quote.company, date: Date.today)
      new_quote
    else
      Stock.create(company: new_quote.company_name, symbol: new_quote.symbol, shares_available: rand(1500),
          sector: new_quote.sector, date: stock_date.date.to_s,open_price: stock_date.open,
          close_price: stock_date.close)
      end
  end

  def buy_stock(symbol)
    stock = stock_quote(symbol)
    puts "\nYour stock is currently trading at $#{stock.delayed_price} per share."
    puts "You can currently afford #{self.balance / stock.delayed_price} share(s)"
    puts  "\nHow many shares would you like to buy? "
    answer = gets.chomp
    new_trade = Trade.create(status: "pending", num_shares: answer, stock_id: stock.id, investor_id: self.id)

    #check if .valid?
    #completed trade if valid and debit account
    #if not valid or cannot find stock error message and return to options

  end


end # end Investor class
