class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :contact, :birthdate, :national_id
end
