class CreateStocks < ActiveRecord::Migration[5.0]
  def change

    create_table(:stocks) do |t|
      t.string :company
      t.string :symbol
      t.integer :shares_available
      t.string :sector
      t.float :week_52_high
      t.float :week_52_low
      t.string :date
      t.integer :open_price
      t.integer :close_price
      t.integer :quote 
    end

  end
end
