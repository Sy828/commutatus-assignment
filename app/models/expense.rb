class Expense < ApplicationRecord
    scope :fetch_all_expenses, -> (current_user_id) { where('created_by = ? ', current_user_id) }
    
    def self.fetch_unpaid_expenses(user_id)
        self.joins("join user_expense_spendings ues on ues.expense_id = expenses.id and ues.user_id = #{user_id} and ues.paid_by !=  #{user_id} ")
        .where("ues.deactivated = false and ues.transaction_flag = 'pending' ")
    end

    def self.fetch_expenses_details_by_id(exp_id,user_id)
        
        self.joins("join user_expense_spendings ues on ues.expense_id = expenses.id and expense_id=#{exp_id} and ues.user_id= #{user_id} ")
        .where("ues.deactivated = false ")
        .select("*")
    end

end
