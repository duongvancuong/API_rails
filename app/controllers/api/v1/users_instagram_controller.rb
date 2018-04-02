class Api::V1::UsersInstagramController < ApplicationController
  skip_before_action :authenticate!

  def index
    response = Instagram::User.new.get_info
    json_response(response)
  end
end
