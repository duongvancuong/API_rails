class UsersController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def create
    auth_token = SignUp.perform! user_params
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private
  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
