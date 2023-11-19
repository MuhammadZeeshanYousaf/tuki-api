class Api::V1::ApartmentSerializer < ActiveModel::Serializer
  attributes :id, :number, :license_plate
  has_one :community
end
