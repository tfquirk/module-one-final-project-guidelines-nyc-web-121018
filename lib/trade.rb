class Trade < ActiveRecord::Base

  belongs_to :stock
  belongs_to :investor


  #----------- end class methods -----------------------
  #----------- start instance methods ------------------

end # end Trade class
