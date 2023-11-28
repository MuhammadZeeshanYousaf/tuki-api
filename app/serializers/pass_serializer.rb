class Api::V1::PassSerializer < ActiveModel::Serializer
  attributes :id, :price, :valid_days
end
