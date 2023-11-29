class AnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :topic, :content, :group, :announced_to
end
