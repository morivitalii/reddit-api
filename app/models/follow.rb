# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :community, counter_cache: true
  belongs_to :user
end
