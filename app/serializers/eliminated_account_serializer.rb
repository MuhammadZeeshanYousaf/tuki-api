class EliminatedAccountSerializer < ActiveModel::Serializer
  attributes :reason, :message, :eliminated_at

  def eliminated_at
    object.created_at
  end

end
