class AddDateColumnTrades < ActiveRecord::Migration[5.0]
  def change
    add_column :trades, :date, :datetime
  end
end
