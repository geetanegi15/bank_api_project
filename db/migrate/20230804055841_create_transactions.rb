class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :cust_id
      t.string :type
      t.integer :amount
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
