require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "example user", email: "yes@yes.com")
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
end
