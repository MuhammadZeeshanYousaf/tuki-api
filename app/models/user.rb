class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :assignments
  has_many :roles, through: :assignments
  belongs_to :community


  # @param role_key[Symbol|String]
  # @return [Boolean]
  def role?(role_key)
    !!(roles&.reduce(false) do |accum, role|
      if role_key.to_s.eql?('admin_or_super')
        accum || role.admin? || role.super_admin?
      else
        accum || role.send(role_key.to_s + '?')
      end
    end)
  end

end
