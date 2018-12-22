class RemoveWeekHighlowColumns < ActiveRecord::Migration[5.0]
  def change

    remove_column :stocks, :week_52_high
    remove_column :stocks, :week_52_low
  end
end
