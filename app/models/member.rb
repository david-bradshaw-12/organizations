class Member < ActiveRecord::Base
  belongs_to :group, required: true
  belongs_to :user, required: true
end
