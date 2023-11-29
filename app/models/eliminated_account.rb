class EliminatedAccount < ApplicationRecord
  belongs_to :eliminated, polymorphic: true
end
