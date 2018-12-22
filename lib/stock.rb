class Stock < ActiveRecord::Base

  has_many :trade
  has_many :investor, through: :trade 


end # end Stock class
