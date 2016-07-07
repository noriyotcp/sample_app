require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: 'Lorem Ipsum')
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user = nil
    assert_not @micropost.valid?
  end

  test 'content should be present' do
    @micropost.content = ' '
    assert_not @micropost.valid?
  end

  test 'content should be at most 140 characters' do
    @micropost.content = 'a' * 141
    assert_not @micropost.valid?
  end

  test 'should return same name with both .user.name and #user_name' do
    assert_equal @micropost.user.name, @micropost.user_name
  end
end
