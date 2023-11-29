class Announcement < ApplicationRecord
  enum :group, { alert: 0, warning: 1 }
  belongs_to :user

  validates :content, presence: true
end
