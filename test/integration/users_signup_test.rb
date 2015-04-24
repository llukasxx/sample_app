require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup info" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", email: "user@invalid", 
                               password: "123", passowrd_confirmation: "321"}
      after_count = User.count
    end
    assert_template 'users/new'
  end

  test "valid signup info" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example", email: "user@valid.com", 
                               password: "password", passowrd_confirmation: "password"}
    end
    assert_template 'users/show'
  end
end
