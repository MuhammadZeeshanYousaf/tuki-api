class Community < ApplicationRecord
  has_many :users
  has_many :apartments
  has_many :owners, through: :apartments
  has_many :co_owners, through: :owners
  has_many :events

  validates :name, presence: true
end
