class DashboardsController < ApplicationController
  include DashboardsHelper
  before_action :set_dashboard, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /dashboards or /dashboards.json
  def index
     
    @dashboards = Dashboard.all
    @friend_list = User.fetch_all_user(current_user.id)
    @expense_list = Expense.fetch_all_expenses(current_user.id)
    @user_are_owed=User.fetch_details_of_user_transactions(current_user.id,0)
    @user_owe=User.fetch_details_of_user_transactions(current_user.id,1)
    @total_amt_to_be_pay = @user_owe.to_a.map { |e| e.shared_amount }.sum
    @total_amt_to_get = @user_are_owed.to_a.map { |e| e.shared_amount }.sum 
    @total_bal= @total_amt_to_get - @total_amt_to_be_pay
    @incr_decr =  @total_amt_to_get >= @total_amt_to_be_pay ? "+" : "-"
    
  end

  # GET /dashboards/1 or /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards or /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to dashboard_url(@dashboard), notice: "Dashboard was successfully created." }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1 or /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to dashboard_url(@dashboard), notice: "Dashboard was successfully updated." }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1 or /dashboards/1.json
  def destroy
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: "Dashboard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dashboard_params
      params.fetch(:dashboard, {})
    end
end
