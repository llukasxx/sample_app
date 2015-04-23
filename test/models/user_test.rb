require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validator should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_USER-M@foo.bar.org 
                      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid|
      @user.email = valid
      assert @user.valid?
    end
  end

  test "email validator should reject invalid addresses" do
    invalid_addresses = %w[user@emaple,com user_at_foo.org user.name@example. 
                        foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid|
      @user.email = invalid
      assert_not @user.valid?
    end
  end

  test "email address should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "password have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
