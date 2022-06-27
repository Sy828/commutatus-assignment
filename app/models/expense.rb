class Expense < ApplicationRecord

    def self.fetch_all_expenses(user_id)
        self.joins("join user_expense_spendings ues on ues.expense_id = expenses.id and ues.user_id = #{user_id} and ues.paid_by !=  #{user_id} ")
        .where("ues.deactivated = false and ues.transaction_flag = 'pending' ")
    end

end
