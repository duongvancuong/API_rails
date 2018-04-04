class AuthToken < ApplicationRecord
  include SecuredGenStr

  belongs_to :user

  validates :token, presence: true, length: {maximum: Settings.validations.strings.max_length}
  validates :refresh_token, presence: true, length: {maximum: Settings.validations.strings.max_length}
  validates :expired_at, presence: true

  class << self
    def generate! user, remember = false
      token = find_or_initialize_by user: user
      token.renew! remember
    end

    def from_token! token
      find_by(token: token).tap{|t| raise(ExceptionHandler::TokenExpired) if t&.expired?}
    end
  end

  def renew! remember = false
    update_attributes! token: unique_random(:token),
      refresh_token: unique_random(:refresh_token),
      expired_at: Settings.auth_tokens.public_send(remember ? :expires_in : :short_expires_in).second.from_now
    self
  end

  def expired?
    expired_at <= Time.now
  end

  def expired!
    update_attributes! expired_at: Time.zone.now
  end
end
