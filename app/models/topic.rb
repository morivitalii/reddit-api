# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :post, touch: true
end
