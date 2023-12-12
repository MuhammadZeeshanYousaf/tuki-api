module QrEncodeable
  extend ActiveSupport::Concern

  # @return [RQRCode::QRCode]
  def generate_qr
    qr_info = Base64.encode64(self.id).chomp + '.' + Base64.encode64(self.class.to_s).chomp
    RQRCode::QRCode.new(qr_info)
  end
end
