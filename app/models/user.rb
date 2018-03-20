require 'bcrypt'

class User < ApplicationRecord

  include BCrypt
  include SecureRandom

  before_insert_email { self.email = email.downcase }
  before_insert_username { self.username = username.downcase }
  validates :username, presence: true, length: { maximum: 32 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates 
end
