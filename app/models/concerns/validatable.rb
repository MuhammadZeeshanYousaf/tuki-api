# frozen_string_literal: true

module Validatable
  extend ActiveSupport::Concern

  included do
    enum :validation_status, { pending: 0, checked_in: 1, checked_out: 2, cancelled: 3 }, prefix: true
  end
end
