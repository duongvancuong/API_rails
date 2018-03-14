class SignUp
  include Base

  def perform! params
    return if User.find_by email: params[:email]
    user = User.find_or_initialize_by email: params[:email]
    user.update_attributes! params
    AuthToken.generate! user
  end
end
