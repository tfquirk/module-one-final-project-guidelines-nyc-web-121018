class CreateAccounts < ActiveRecord::Migration[5.0]
  def change

    create_table(:accounts) do |t|
      t.float :balance
      t.integer :investor_id
      t.integer :bank_id
    end


  end
end
