class Trade < ActiveRecord::Base

  belongs_to :stock
  belongs_to :investor

end # end Trade class
