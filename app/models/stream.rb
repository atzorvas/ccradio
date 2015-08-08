class Stream < ActiveRecord::Base
  validates :title, :server, :mount, presence: true
  validates :title, uniqueness: true
  validates :mount, uniqueness: true
end
