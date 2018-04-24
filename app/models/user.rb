require 'pbkdf2'

class User < ApplicationRecord

  acts_as_messageable
  has_many :posts

  include SecureRandom

  # allows virtual attributes to be 'get' and 'set'
  attr_accessor :password, :password_confirmation, :password_salt, :pass_hash

  # this and block below it makes sure username and email
  # is lowercase before being saved in the database
  before_save :lower
  before_save :pass_hash

  def lower
     self.email = email.downcase
     self.username = username.downcase
  end

  validates :username, presence: true, length: { maximum: 32 },
            uniqueness: {case_sensitive: false}

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
  # also does hashing on server

  #virtual attribute
  def password=(unencrypted_password)
    @password = unencrypted_password
  end

  #virtual attribute
  def pass_hash

    # *.unpack("B*").first gets binary string
    salt = SecureRandom.base64(64).unpack("B*").first

    # block to hash password
    @pass_hash = PBKDF2.new do |p|
      p.password = @password.unpack("B*").first
      p.salt = salt
      p.iterations = 10000
    end

    # updates columns from users table in memory; doesn't write to database yet
    self.password_salt = salt
    self.password_hash = @pass_hash.hex_string
  end

private

  # Checks if user inputted password correctly both times
  def confirm_password?
    password || password_confirmation
  end
end
