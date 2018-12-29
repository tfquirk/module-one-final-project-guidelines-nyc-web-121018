class Stock < ActiveRecord::Base

  has_many :trade
  has_many :investor, through: :trade

  #returns total number of shares_available for all stocks
  def self.total_available_shares
    shares = self.all.map { |stock| stock.shares_available }
    puts shares.inject {|sum, a| sum + a }
  end

  #lists all individuals who currently own stock
  def self.list_of_investors
    investors = Trade.all.map { |trade| trade.investor_id if trade.bought_sold == "bought"}
    investors.each { |el| puts Investor.all.find(el).name  }
  end

  # calls the IEX gem and gets a hash quote of data for any stock symbol
  def self.stock_quote(symbol)
    IEX::Resources::Quote.get(symbol)
  end

  #finds record from or creates new record for the stock database
  def self.find_or_create_stock_from_quote(quote)
    find_stock = Stock.all.select {|stock| stock.symbol == quote.symbol }
    if find_stock.length > 0                                                #checks to see if record exits in database
      if find_stock.last.date == Date.today.to_s                            #if last record is from today, we just update
        found_stock = find_stock.last                                       #otherwise, create a new record for today
        found_stock.quote = quote.delayed_price
        found_stock.save
        return found_stock
      else
        Stock.create(company: quote.company_name, symbol: quote.symbol,                 #create because date != today
          shares_available: rand(1500), sector: quote.sector, date: Date.today,
          open_price: quote.open, close_price: quote.close, quote: quote.delayed_price)
      end
    else
      Stock.create(company: quote.company_name, symbol: quote.symbol,                   #create because no record of
        shares_available: rand(1500), sector: quote.sector, date: Date.today,           #stock in database 
        open_price: quote.open, close_price: quote.close, quote: quote.delayed_price)
    end
  end

  #finds the date of the previous Friday
  def self.prior_friday(date)
    days_before = (date.wday + 1) % 7 + 1
    date.to_date - days_before
  end

  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  #displays current quote information/analysis for user
  def self.research_quote(quote, user)
    puts "\nCurrent stock information for #{quote.company_name}:"
    puts "\tCurrent trading price: $#{quote.delayed_price}"
    puts "\tGiven your current bank account balance of: $#{user.balance}"
    puts "\tyou can afford to buy #{(user.balance / quote.delayed_price).round(2)} shares of this stock." if user.balance > 0
  end
end # end Stock class
