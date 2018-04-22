require 'pbkdf2'

module SessionsHelper

  include SecureRandom
  
  # authenticates user by taking the salt and hash associated with
  # inputted user (if any), then hashing the inputted password
  # then the newly calculated password hash is checked against the one
  # stored in the database
  # returns true if password hashes match, false otherwise
  def authenticate(user, password)
    salt = user.password_salt 

    hash = PBKDF2.new do |p|
      p.password = password.unpack("B*").first
      p.salt = salt
      p.iterations = 10000
    end

    pass_hash = hash.hex_string
   
    pass_hash == user.password_hash 
  end


  # logs in user
  def log_in(user)
    session[:user_id] = user.id
  end

  # gets current logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #check if user is logged in
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
  end
end
