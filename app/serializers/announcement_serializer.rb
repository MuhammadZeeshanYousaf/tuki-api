class AnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :topic, :content, :group, :announced_to, :announced_to_user
end
