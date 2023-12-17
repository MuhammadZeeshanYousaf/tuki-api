class Apartment < ApplicationRecord
  belongs_to :community
  has_many :owners,  dependent: :destroy
  has_many :co_owners, through: :owners
  has_many :tenants

  validates :number, presence: true, uniqueness: true
end
