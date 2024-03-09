class User < ApplicationRecord
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one :assignment, dependent: :destroy
  has_one :role, through: :assignment
  belongs_to :community
  has_one :owner, dependent: :destroy
  has_one :co_owner, -> { where.not(ownership: nil) }, class_name: 'Owner', dependent: :destroy
  has_many :co_owners, through: :owner
  has_one :tenant, dependent: :destroy
  has_many :co_tenants, through: :tenant
  has_one :guest, -> { where(type: nil) }, dependent: :destroy
  has_many :guest_invitations, -> { where(type: nil) }, class_name: 'Guest', foreign_key: 'invited_by_id'
  has_one :working_guest, dependent: :destroy
  has_many :working_guest_invitations, -> { where(type: WorkingGuest.to_s) }, class_name: 'Guest', foreign_key: 'invited_by_id'
  has_many :guest_approvals, class_name: 'Guest', foreign_key: 'approved_by_id'
  has_many :bookings, foreign_key: 'booker_id'
  has_many :announcements
  has_many :my_announcements, class_name: 'Announcement', foreign_key: 'announced_to'
  has_many :validations, foreign_key: 'validated_by_id'
  has_one :allocation, class_name: 'Event', foreign_key: 'allocated_guard_id'

  validates :email, :national_id, presence: true, uniqueness: true
  delegate *Role.keys.keys.map { |m| m + '?' }.append(:key), to: :role, prefix: true, allow_nil: true
  # Random password is generated before saving a new user
  before_save :generate_random_password
  after_create :send_add_user_email, if: :can_send_add_user_email?


  def name
    "#{first_name} #{last_name}"
  end

  private

    # Add this method to generate and assign a random password
    def generate_random_password
      # random_password = SecureRandom.hex(4)[0, 8] # Generates a random 8-character hexadecimal string
      generated_password = Devise.friendly_token.first(8)
      self.password = generated_password
      self.password_confirmation = generated_password
    end

    def can_send_add_user_email?
      %w(owner co_owner tenant co_tenant guest working_guest).include? self.role_key
    end

    def send_add_user_email
      UserMailer.with(user: self, password: self.password).add_user.deliver_later
    end

end
