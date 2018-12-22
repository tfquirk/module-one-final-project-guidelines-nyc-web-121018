class CreateTrades < ActiveRecord::Migration[5.0]
  def change

    create_table(:trades) do |t|
      t.integer :stock_id
      t.integer :investor_id
      t.float :stock_price
      t.float :num_shares
      t.string :status
      t.float :purchase_price
    end

  end
end
