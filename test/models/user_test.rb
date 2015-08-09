require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "'registered' as a default role for new users" do
    user = User.create!(:email => 'user@example.com',
                        :password => 'secretpass',
                        :password_confirmation => 'secretpass')
    assert_equal user.role.name, "registered"
  end
end
