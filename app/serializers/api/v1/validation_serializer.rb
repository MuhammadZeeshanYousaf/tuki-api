class Api::V1::ValidationSerializer < ActiveModel::Serializer
  attributes :id, :status, :note
  has_one :booking
  has_one :validated_by
end
