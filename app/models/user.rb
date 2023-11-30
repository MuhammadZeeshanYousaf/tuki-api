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
  has_many :tenants, dependent: :destroy
  has_many :co_owners, through: :owner
  has_many :bookings
  has_many :announcements
  has_many :my_announcements, class_name: 'Announcement', foreign_key: 'announced_to'

  validates :email, :national_id, presence: true, uniqueness: true
  delegate *Role.keys.keys.map { |m| m + '?' }.append(:key), to: :role, prefix: true
  after_create :send_add_user_email, if: :can_send_add_user_email?


  def name
    "#{first_name} #{last_name}"
  end

  private

    def can_send_add_user_email?
      %w(owner co_owner tenant co_tenant).include? self.role_key
    end

    def send_add_user_email
      UserMailer.with(user: self).add_user.deliver_later
    end

end
