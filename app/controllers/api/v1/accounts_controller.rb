class Api::V1::AccountsController < ApplicationController
  #include ActionController::HttpAuthentication::Token
  before_action :set_account, only: %i[ show update destroy ]

  # GET /accounts
  # GET /accounts.json

  def index
    authorize :account, :index?
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    if @account.save
      render :show, status: :created, location: api_v1_account_url(@account)
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    if @account.update(account_params)
      render :show, status: :ok, location:api_v1_account_url(@account)
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    if @account.destroy
      render json: {notice: "Account was deleted successfully"}, status: :ok
    else
      render json: {notice: "Error deleting the account", errors: @account.errors, status: :error}, status: :unprocessable_entity
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
      authorize @account
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit( :name, :client_name, :user_id, team_ids: [] )
    end
end
