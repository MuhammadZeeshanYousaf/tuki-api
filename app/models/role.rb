class Role < ApplicationRecord
  enum :key, {
    member: 0,
    guard: 1,
    admin: 2,
    super_admin: 3,
    guest: 4,
    owner: 5,
    tenant: 6
  }

  has_many :assignments
  has_many :users, through: :assignments

  validates :name, presence: true, uniqueness: true

end
