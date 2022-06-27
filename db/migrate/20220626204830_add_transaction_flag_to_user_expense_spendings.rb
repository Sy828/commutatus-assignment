class AddTransactionFlagToUserExpenseSpendings < ActiveRecord::Migration[6.1]
  def change
    add_column :user_expense_spendings, :transaction_flag, :string, default: "pending" 
  end
end
