class Instagram::User
  include Base

  CACHE_DEFAULTS = { expires_in: 7.days, force: false }

  def get_info_owner clear_cache = false
    url = "#{ENV["URI_BASE_USER"]}self/"
    cache_params = CACHE_DEFAULTS.merge({force: clear_cache})
    response = Request.where(url, cache_params, query_params)
  end

  def get_info_user user_id, clear_cache = false
    url = "#{ENV["URI_BASE_USER"]}#{user_id}"
    cache_params = CACHE_DEFAULTS.merge({force: clear_cache})
    response = Request.where(url, cache_params, query_params)
  end

  def media_recent_owner params_media={}, clear_cache = false
    url = "#{ENV["URI_BASE_USER"]}self/media/recent/"
    cache_params = CACHE_DEFAULTS.merge({force: clear_cache})
    response = Request.where(url, cache_params, query_params.merge(params_media))
  end

  def media_recent_user user_id, params_media = {}, clear_cache = false
    url = "#{ENV["URI_BASE_USER"]}#{user_id}/media/recent/"
    cache_params = CACHE_DEFAULTS.merge({force: clear_cache})
    response = Request.where(url, cache_params, query_params.merge(params_media))
  end

  def media_liked params_media = {}, clear_cache = false
    url = "#{ENV["URI_BASE_USER"]}self/media/liked"
    cache_params = CACHE_DEFAULTS.merge({force: clear_cache})
    response = Request.where(url, cache_params, query_params.merge(params_media))
  end

  def user_search params_search = {}, clear_cache = false
    url = "#{ENV["URI_BASE_USER"]}search"
    cache_params = CACHE_DEFAULTS.merge({force: clear_cache})
    response = Request.where(url, cache_params, query_params.merge(params_search))
  end

  private
  def query_params
    {
      access_token: ENV["ACCEESS_TOKEN_INSTAGRAM"]
    }
  end
end
