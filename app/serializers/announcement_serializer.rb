class AnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :content, :type, :announced_to
  has_one :user
end
