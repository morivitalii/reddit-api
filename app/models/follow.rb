# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :sub, touch: true, counter_cache: true
  belongs_to :user
end
