class Validation < ApplicationRecord
  enum :status, { valid_user: 0, invalid_user: 1 }

  belongs_to :booking
  belongs_to :validated_by, class_name: 'User'
end
