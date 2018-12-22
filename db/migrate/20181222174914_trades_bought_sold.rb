class TradesBoughtSold < ActiveRecord::Migration[5.0]
  def change
    add_column :trades, :bought_sold, :string 
  end
end
