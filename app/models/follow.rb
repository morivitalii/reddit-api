# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :sub, touch: true, counter_cache: true
  belongs_to :user, touch: :follows_updated_at
end
