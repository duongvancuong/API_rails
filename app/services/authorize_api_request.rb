class AuthorizeApiRequest
  include Base

  attr_reader :headers

  def initialize headers = {}
    @headers = headers
  end

  def perform!
    raise(ExceptionHandler::InvalidToken, Message.invalid_token) unless current_user
    current_user
  end
  private
  def current_user
    @current_user ||= AuthToken.from_token!(http_auth_header)&.user
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
