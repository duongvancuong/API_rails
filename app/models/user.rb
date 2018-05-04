class User < ApplicationRecord
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # encrypt password
  has_secure_password

  # Model associations
  has_many :todos, foreign_key: :created_by
  has_many :posts, dependent: :destroy
  # Validations
  validates_presence_of :name, :email, :password_digest
  validates :email, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
end
