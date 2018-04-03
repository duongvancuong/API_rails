class Api::V1::UsersInstagramController < ApplicationController
  skip_before_action :authenticate!

  def index
    response = Instagram::User.new.get_info_owner()
    json_response(response)
  end

  def media_recent_owner
    json_response(Instagram::User.new.media_recent_owner(query_params))
  end

  def media_recent_user
    json_response(Instagram::User.new.media_recent_user(params[:user_id], query_params))
  end

  def media_liked
    json_response(Instagram::User.new.media_liked(query_media_liked_params))
  end

  def user_search
    json_response(Instagram::User.new.user_search(query_search_params))
  end

  private
  def query_params
    params.permit(:max_id, :min_id, :count)
  end

  def query_search_params
    params.permit(:q, :count)
  end

  def query_media_liked_params
    params.permit(:max_like_id, :count)
  end
end
