class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX }

  has_many :members, dependent: :destroy
  has_many :members_of, through: :member, source: :event
end
