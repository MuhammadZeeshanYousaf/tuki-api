class Announcement < ApplicationRecord
  enum :group, { alert: 0, warning: 1 }
  belongs_to :user
  belongs_to :announced_to_user, class_name: 'User', foreign_key: 'announced_to'

  validates :content, presence: true
end
