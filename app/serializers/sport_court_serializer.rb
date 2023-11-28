class SportCourtSerializer < ActiveModel::Serializer
  attributes :id, :name, :sport, :rent
  has_one :community
end
