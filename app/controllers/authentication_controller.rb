class AuthenticationController < ApplicationController
  skip_before_action :authenticate!, only: :login

  def login
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).perform!
    hash_authen = {
      status: true,
      data: {
          token: auth_token
      }
    }
    json_response(hash_authen)
  end

  private
  def auth_params
    params.permit(:email, :password)
  end
end
