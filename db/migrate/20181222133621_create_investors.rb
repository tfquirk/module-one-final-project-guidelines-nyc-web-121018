class CreateInvestors < ActiveRecord::Migration[5.0]
  def change

    create_table(:investors) do |t|
      t.string :name
      t.integer :age
      t.string :address
      t.string :city
      t.string :state
      t.string :email
      t.string :phone_num
      t.integer :account_id
    end

  end
end
