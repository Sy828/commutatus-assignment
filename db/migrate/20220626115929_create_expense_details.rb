class CreateExpenseDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_details do |t|
      t.datetime :expense_date
      t.string :borrowed_or_lent
      t.integer :paid_by,null: false
      
      t.timestamps
    end
  end
end
