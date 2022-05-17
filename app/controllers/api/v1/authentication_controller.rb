class Api::V1::AuthenticationController < ActionController::API
    before_action :authenticate_user!
  #rescue_from ActionController::ParameterMissing, with: :parameter_missing
#
#  #def create
#  #  #params.require(:user).permit(:email,:password).inspect
#  #  user = User.where( email: params[:user][:email] ).first
#  #  #password: params[:user][:password]
#
#  #  render json: { token: AuthenticationTokenService.call(user.id) }, status: :created
#  #end
#
#  ## shelba@beatty.co
#  ## 123123
#  ## eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3NH0.XpoSEd7W7xjiDWfDOUL3fRgJDxgnUBWTHCUDe8OW_z0
#  #private
#
#  #def parameter_missing(e)
#  #  render json: { error: e.message }, status: :unprocessable_entity
  #end
end