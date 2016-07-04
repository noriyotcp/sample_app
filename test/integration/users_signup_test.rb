require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid singup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, user: { name: '',
                                email: 'user@invalid',
                                password: 'foo',
                                password_confirmation: 'bar' }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid singup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, user: { name: 'Example User',
                                email: 'user@example.com',
                                password: 'foobar',
                                password_confirmation: 'foobar' }
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
    assert_not flash.empty?
    assert_equal flash[:info], 'Please check your email to activate your account.'
  end
end
