module SecuredGenStr
  extend ActiveSupport::Concern

  class_methods do
    def generate_password_digest password
      BCryt::Password.create password
    end
  end

  private
  def unique_random attr
    str_len = Settings.public_send(self.class.name.underscore.pluralize)
      .public_send(attr)
      .public_send(:secure_length).to_i / 2
    loop do
      str = SecureRandom.hex str_len
      break str unless self.class.exists?(attr => str)
    end
  end
end
