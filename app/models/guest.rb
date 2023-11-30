class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :invited_by, class_name: 'User'
  belongs_to :approved_by, class_name: 'User'
end
