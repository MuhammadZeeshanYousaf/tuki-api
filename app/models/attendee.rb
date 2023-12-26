class Attendee < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :qr_image
  belongs_to :booking
  belongs_to :user
  alias_attribute :account_id, :user_id
  validates :user_id, uniqueness: { scope: [:booking_id, :user_id] }
  after_create :attach_qr_image


  private
    def attach_qr_image
      qr = RQRCode::QRCode.new("#{ENV['HOST_URL']}#{api_v1_attendee_qr_path(id)}")
      qr_png = qr.as_png(
        bit_depth: 1,
        border_modules: 2,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: "black",
        file: nil,
        fill: "white",
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 320
      )
      self.qr_image.attach(io: StringIO.new(qr_png.to_s), filename: "qr_image_#{id}.png", content_type: "image/png")
    end
end
