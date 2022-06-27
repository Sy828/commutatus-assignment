class UserExpenseSpending < ApplicationRecord
  validates :total_amount,
            :presence => true
  validates :shared_amount,
            :presence => true
  validates :user_id,
            :presence => true
  validates :expense_id,
            :presence => true
  validates :paid_by,
            :presence => true
  validates :transaction_flag,
            :presence => true          
           


    scope :fetch_amoun_to_be_pay, -> (expenseId,current_user) { where('user_id = ? and expense_id = ?', current_user.id,expenseId) }
end
