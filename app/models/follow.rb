# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :community, counter_cache: :followers_count
  belongs_to :user
end
