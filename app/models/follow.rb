# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :community, touch: true, counter_cache: true
  belongs_to :user, touch: true
end
