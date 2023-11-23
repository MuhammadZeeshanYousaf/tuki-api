class Owner < ApplicationRecord
  belongs_to :user
  belongs_to :apartment

  has_many :co_owners, class_name: "Owner", foreign_key: "ownership_id"
  belongs_to :ownership, class_name: 'Owner', optional: true
end
