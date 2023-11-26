class Api::V1::RoleSerializer < ActiveModel::Serializer
  attributes :id, :name, :key
end
