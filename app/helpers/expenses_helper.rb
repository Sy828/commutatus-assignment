module ExpensesHelper

    def save_user_expenses(params,current_user)
        index = 0
        expense=Expense.create!(name: params[:exp_name],description: params[:exp_desc],created_by: current_user.id,deactivated: false)
        if !params[:friends_ids].nil? && !expense.nil? 
        params[:friends_ids].push(current_user.id)
            params[:friends_ids].each do |friendId|
                shared_amount = split_into params[:exp_amount].to_f,params[:friends_ids].length.to_f 
                paid_by = !params[:paid_friends_id].nil? && !params[:paid_friends_id].blank? ? params[:paid_friends_id] : current_user.id
                split_amt_user=UserExpenseSpending.create!(user_id: friendId,expense_id: expense.id,shared_amount: shared_amount[index],total_amount: params[:exp_amount],expense_date: params[:expense_date],borrowed_or_lent: params[:borroed_or_lent],paid_by: paid_by,deactivated: false)    
                if current_user.id == friendId
                split_amt_user.update(transaction_flag: "done")
                end  
                index = index+1 
            end
        else
            UserExpenseSpending.create!(user_id: current_user.id,expense_id: expense.id,shared_amount: params[:exp_amount],total_amount: params[:exp_amount],expense_date: params[:expense_date],borrowed_or_lent: params[:borroed_or_lent],paid_by: current_user.id,deactivated: false,transaction_flag: "done")
        end  
    end 

    def split_into n, p
        return [n/p + 1] * (n%p) + [n/p] * (p - n%p)
    end

    def settle_up_user_dues
         
        user_transctn=UserTransaction.create!(user_id: current_user.id,expense_id: params[:expense_id],paid_amount: params[:amount_paid])
        if !user_transctn.nil? && !user_transctn.blank? 
        UserExpenseSpending.find_by(user_id: current_user.id,expense_id: params[:expense_id]).update(transaction_flag: "done")
        end  
    
    end    

end
