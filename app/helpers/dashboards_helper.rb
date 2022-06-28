module DashboardsHelper

    def expense_details(params,userID)
        Expense.fetch_expenses_details_by_id(params[:expense_id],userID).first
    end 

end
