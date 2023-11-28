class ApartmentSerializer < ActiveModel::Serializer
  attributes :id, :number, :license_plate
  has_one :community
end
