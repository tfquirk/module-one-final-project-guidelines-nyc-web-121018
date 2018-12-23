class Trade < ActiveRecord::Base

  belongs_to :stock
  belongs_to :investor
  has_many :account, through: :investor


  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

  def valid?
    #check funds available # check shares available # check trade not completed

    if self.num_shares * Stock.find(self.stock_id).quote > Account.find_by(investor: self.investor_id).balance
      return false
    elsif self.status != "pending"
      return false
    elsif Stock.all.find_by(id: self.stock_id).shares_available < self.num_shares
      return false
    else
      return true
    end
  end

end # end Trade class
