class ApplicationController < ActionController::API
  include Pundit::Authorization
  #before_action :authenticate_user!

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

  ## def user_not_authorized
  ##   flash[:alert] = "You are not authorized to perform this action."
  ##   redirect_back(fallback_location: root_path)
  ## end

  ## def authenticate
  ##   begin
  ##     token, _options = token_and_options(request)
  ##     user_id = AuthenticationTokenService.decode(token)
  ##     User.find( user_id )
  ##   rescue StandardError => e
  ##     render json: [status: :unauthorized]
  ##   end
  ## end
end
