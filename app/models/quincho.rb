class Quincho < ApplicationRecord
  belongs_to :community

  validates :name, presence: true
end
