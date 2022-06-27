class CreateUserTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_transactions do |t|
      t.integer :user_id,null: false
      t.integer :expense_id,null: false
      t.decimal :paid_amount

      t.timestamps
    end
  end
end
