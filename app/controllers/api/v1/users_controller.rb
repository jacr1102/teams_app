class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  # GET /users.json
  def index
    authorize :user, :index?
    @users = User.includes(:profile).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: api_v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      #flash.now[:notice] = "User was updated successfully"
      render :show, status: :ok, location: api_v1_user_url(@user)
    else
      render json: { notice: "Error updating the user", errors: @user.errors, status: :error}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      render json: {notice: "User was deleted successfully"}, status: :ok
    else
      render json: {notice: "Error deleting the user", errors: @user.errors, status: :error}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.includes(:profile, :role).find(params[:id])
      authorize @user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit :first_name, :username, :last_name, :password, :email, profile_attributes: [ :id, :user_id, :english_level, :technical_experience, :cv_link ]
    end
end
