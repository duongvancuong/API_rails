class Instagram::User
  include Base

  def get_info
    url = "/v1/users/self/"
    query = {access_token: ENV["ACCEESS_TOKEN_INSTAGRAM"]}
    response = Request.where(url,query)
  end
end
