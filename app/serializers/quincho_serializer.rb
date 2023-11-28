class Api::V1::QuinchoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :is_grilled
  has_one :community
end
