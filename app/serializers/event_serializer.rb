class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :seats, :start_time, :end_time, :start_date, :end_date
  has_one :ticket
  has_many :passes


  def start_time
    object.start_time.strftime('%H:%M:%S') if object.start_time
  end

  def end_time
    object.end_time.strftime('%H:%M:%S') if object.end_time
  end

  def start_date
    object.start_date.strftime('%Y-%m-%d') if object.start_date
  end

  def end_date
    object.end_date.strftime('%Y-%m-%d') if object.end_date
  end

end
