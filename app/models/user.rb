class User < ActiveRecord::Base
  belongs_to :role
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  private

  def set_default_role
    self.role ||= Role.find_by_name('registerd')
  end
end
