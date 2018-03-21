require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "example user", email: "yes@yes.com",
                     password: "kdjdlllll", password_confirmation: "kdjdlllll",
                    # password_hash: "123456789", password_salt: "dkfjkdjf"
                    )
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do 
    @user.username = "    "
    assert_not @user.valid?
  end

  test "email should be present" do 
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
