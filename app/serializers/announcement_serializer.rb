class AnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :topic, :content, :group
end
