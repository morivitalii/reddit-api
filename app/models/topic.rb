# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :post, class_name: "Thing", foreign_key: "post_id"
end
