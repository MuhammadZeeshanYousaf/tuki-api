module QrAttachable
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
    has_one_attached :qr_image
    after_create :attach_qr_image

    private

      # @abstract
      def qr_image_data
        raise NotImplementedError, "Subclasses must implement this method"
      end

      def attach_qr_image
        qr = RQRCode::QRCode.new qr_image_data
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
        self.qr_image.attach(io: StringIO.new(qr_png.to_s), filename: "attendee_qr_image_#{id}.png", content_type: "image/png")
      end
  end

end
