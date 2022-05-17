class ApplicationController < ActionController::API

private
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
