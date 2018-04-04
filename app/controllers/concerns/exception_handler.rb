module ExceptionHandler
  extend ActiveSupport::Concern
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class TokenExpired < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :response_error
    rescue_from ExceptionHandler::MissingToken, with: :response_error
    rescue_from ExceptionHandler::InvalidToken, with: :response_error
    rescue_from ExceptionHandler::TokenExpired, with: :response_error

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end

  private
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def response_error e
    error_type = e.class.name.scan(/ExceptionHandler::(.*)/).flatten.first.underscore.to_sym
    response = {
      message: Settings.handle_error.public_send(error_type).message,
      error_code: Settings.handle_error.public_send(error_type).error_code
    }
    render json: response, status: :bad_request
  end
end
