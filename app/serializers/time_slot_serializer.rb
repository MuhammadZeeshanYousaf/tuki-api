class TimeSlotSerializer < ActiveModel::Serializer
  attributes :id, :day, :start_time, :end_time, :available_seats

  def start_time
    object.start_time.strftime('%H:%M:%S') if object.start_time
  end

  def end_time
    object.end_time.strftime('%H:%M:%S') if object.end_time
  end
end
