class Guest < ApplicationRecord
  include QrAttachable

  belongs_to :user
  alias_method :account, :user
  belongs_to :invited_by, class_name: 'User'
  belongs_to :approved_by, class_name: 'User', optional: true
  after_create :attach_qr_image

  protected

    def qr_image_data
      "#{ENV['HOST_URL']}#{validate_api_v1_guest_path(id)}"
    end
end
