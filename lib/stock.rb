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

  #----------- end class methods -----------------------
  #----------- start instance methods ------------------


end # end Stock class
