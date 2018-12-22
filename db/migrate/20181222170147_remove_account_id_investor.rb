class RemoveAccountIdInvestor < ActiveRecord::Migration[5.0]
  def change
    remove_column :investors, :account_id
  end
end
