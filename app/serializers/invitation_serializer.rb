class InvitationSerializer < ActiveModel::Serializer
  attributes :id, :email, :status
  has_one :user
  has_one :guest
end
