# frozen_string_literal: true

class Staff < ApplicationRecord
  belongs_to :user, touch: :staff_updated_at
end
