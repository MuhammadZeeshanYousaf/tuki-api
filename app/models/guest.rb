class Guest < ApplicationRecord
  include QrAttachable

  belongs_to :user
  alias_method :account, :user
  belongs_to :invited_by, class_name: 'User'
  belongs_to :approved_by, class_name: 'User', optional: true
  validates :user, presence: true, uniqueness: { message: 'Guest already exist' }
  after_create :send_guest_email

  def is_valid?
    valid_from <= DateTime.current && valid_to >= DateTime.current if valid_from.present? && valid_to.present?
  end

  private

    def qr_image_data
      "#{ENV['HOST_URL']}#{validate_api_v1_guest_path(id)}"
    end
    def send_guest_email
      # @Todo - get guest details and send QR code email to guest
    end
end
