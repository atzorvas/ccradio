class User < ActiveRecord::Base
  belongs_to :role
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
    self.role && self.role.name == 'admin'
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
end
