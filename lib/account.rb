class Account < ActiveRecord::Base

  belongs_to :investor
  has_many :trade, through: :investor


end # end Account class
