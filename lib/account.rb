class Account < ActiveRecord::Base

  belongs_to :investor
  has_many :trades, through: :investors


end # end Account class
