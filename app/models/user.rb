class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one :assignment
  has_one :role, through: :assignment
  belongs_to :community

  delegate *Role.keys.keys.map { |m| m + '?' }.append(:key), to: :role, prefix: true


end
