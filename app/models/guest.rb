class Guest < ApplicationRecord
  enum :type => { regular: 0, working: 1 }

  belongs_to :user
end
