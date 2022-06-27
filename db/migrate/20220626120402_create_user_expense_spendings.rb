class CreateUserExpenseSpendings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_expense_spendings do |t|

      t.integer :user_id,null: false
      t.integer :expense_id,null: false
      t.decimal :shared_amount
      t.integer :total_amount
      t.datetime :expense_date
      t.string :borrowed_or_lent
      t.integer :paid_by,null: false
      t.boolean :deactivated , null: false, default: false
      t.timestamps null: false
    end

  end
end
