class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :contact, :birthdate, :national_id, :avatar
  has_one :role, serializer: RoleSerializer

  def birthdate
    object.birthdate.strftime('%Y-%m-%d') if object.birthdate.present?
  end

  def avatar
    object.avatar.url
  end

end
