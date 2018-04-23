class Group < ActiveRecord::Base
  belongs_to :user, required: true
  validates :name, :description, presence: true
  validates :name, length: {minimum: 5}
  validates :description, length: {minimum: 10}

  has_many :members, dependent: :destroy
  has_many :users, through: :member, source: :user



end
