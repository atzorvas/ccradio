class User < ActiveRecord::Base
  belongs_to :role
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:wordpress_hosted]

  def admin?
    self.role && self.role.name == 'admin'
  end

  def self.find_for_wordpress_hosted(oauth, signed_in_user=nil)
    if signed_in_user
      return signed_in_user
    else
      user = User.find_by_uid(oauth['uid'])
      if user.nil?
        user = User.create!(email: oauth['info']['email'], uid: oauth['uid'], firstname: 'test', lastname: 'test')
      end
      user
    end
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
end
