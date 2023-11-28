class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one :assignment, dependent: :destroy
  has_one :role, through: :assignment
  belongs_to :community
  has_one :owner, dependent: :destroy
  alias_method :co_owner, :owner
  has_many :bookings

  validates :email, :national_id, presence: true, uniqueness: true

  delegate *Role.keys.keys.map { |m| m + '?' }.append(:key), to: :role, prefix: true


end
