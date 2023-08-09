class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :cust_id
      t.string :name
      t.integer :amount
      t.string :pin
      t.timestamps
    end
  end
end
