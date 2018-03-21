require 'bcrypt'

class User < ApplicationRecord

  include BCrypt
  include SecureRandom

  attr_accessor :password, :password_confirmation, :pass_hash

  before_save :lower

  def lower
     self.email = email.downcase
     self.username = username.downcase
  end

  validates :username, presence: true, length: { maximum: 32 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # confirmation is a helper dealing with ActiveRecord (database) objects
  # it creates an additional confirmation attribute
  # now :password, and :password_confirmation can be used
  validates :password, length: (8..128), confirmation: true, if: :confirm_password?
  validates :password_confirmation, presence: true, length: (8..128)

  # These are virtual attributes to check the password field and 
  # password_confirmation field the user input in the provided form
  # on the view
  # This is so that we do not save plain text passwords in database
  
  #virtual attribute
  def password=(unencrypted_password)
    @password = unencrypted_password
  end

  def pass_hash
    @pass_hash = Password.create(unencrypted_password, :cost => 12)
    self.password_salt = hash.salt
    self.password_hash = @pass_hash
  end

private

  # Checks if user inputted password correctly both times
  def confirm_password?
    password || password_confirmation
  end
end
