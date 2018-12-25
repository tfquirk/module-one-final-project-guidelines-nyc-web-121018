class Stock < ActiveRecord::Base

  has_many :trade
  has_many :investor, through: :trade

  def self.total_available_shares #returns total number of shares_available
    shares = self.all.map { |stock| stock.shares_available }
    puts shares.inject {|sum, a| sum + a }
  end

  def self.list_of_investors #lists all individuals who currently own stock
    investors = Trade.all.map { |trade| trade.investor_id if trade.bought_sold == "bought"}
    investors.each { |el| puts Investor.all.find(el).name  }
  end

  def self.stock_quote(symbol)
    IEX::Resources::Quote.get(symbol)
  end

  def self.find_or_create_stock_from_quote(quote)
    find_stock = Stock.all.select {|stock| stock.symbol == quote.symbol }
    if find_stock.length > 0
      if find_stock.last.date == Date.today || find_stock.last.date == prior_friday(Date.today)
        found_stock = find_stock.last
        found_stock.quote = quote.delayed_price
        found_stock.save
        return found_stock
      else
        Stock.create(company: quote.company_name, symbol: quote.symbol, shares_available: rand(1500),
            sector: quote.sector, date: Date.today,open_price: quote.open, close_price: quote.close, quote: quote.delayed_price)
      end
    else
      Stock.create(company: quote.company_name, symbol: quote.symbol, shares_available: rand(1500),
          sector: quote.sector, date: Date.today,open_price: quote.open, close_price: quote.close, quote: quote.delayed_price)
    end
  end

  def self.prior_friday(date)
    days_before = (date.wday + 1) % 7 + 1
    date.to_date - days_before
  end

  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  # def stock_quote(symbol)
  #   IEX::Resources::Quote.get(symbol)
  # end





end # end Stock class
