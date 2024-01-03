class Attendee < ApplicationRecord
  include QrAttachable
  include Validatable

  belongs_to :booking
  belongs_to :user
  alias_attribute :account_id, :user_id
  validates :user_id, uniqueness: { scope: [:booking_id, :user_id] }


  private

    def qr_image_data
      "#{ENV['HOST_URL']}#{api_v1_attendee_qr_path(id)}"
    end
end
