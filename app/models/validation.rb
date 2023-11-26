class Validation < ApplicationRecord
  enum :status, { valid: 0, not_valid: 1 }

  belongs_to :booking
  belongs_to :validated_by, class_name: 'User'
end
