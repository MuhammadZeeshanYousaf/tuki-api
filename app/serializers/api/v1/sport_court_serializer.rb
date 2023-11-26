class Api::V1::SportCourtSerializer < ActiveModel::Serializer
  attributes :id, :name, :sport, :rent
  has_one :community
end
