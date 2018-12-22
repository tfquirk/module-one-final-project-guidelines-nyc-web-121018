class UpdateStockVariables < ActiveRecord::Migration[5.0]
  def change
    change_column(:stocks, :open_price, :float)
    change_column(:stocks, :close_price, :float)
    change_column(:stocks, :quote, :float)
  end
end
