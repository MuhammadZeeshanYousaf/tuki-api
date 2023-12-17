class EventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :name, :description, :seats, :start_date, :end_date
  has_many :time_slots

  def start_date
    object.start_date.strftime('%Y-%m-%d') if object.start_date
  end

  def end_date
    object.end_date.strftime('%Y-%m-%d') if object.end_date
  end

end
