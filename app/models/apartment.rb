class Apartment < ApplicationRecord
  belongs_to :community
  has_many :owners, -> { where(ownership_id: nil) }, dependent: :destroy
  has_many :co_owners, through: :owners
  has_many :tenants

  validates :license_plate, :number, presence: true, uniqueness: true
end
