class AttendeeSerializer < ActiveModel::Serializer
  attributes :qr_image
  has_one :user, key: :account

  def qr_image
    object.qr_image.url
  end
end
