# frozen_string_literal: true

module Chronological
  extend ActiveSupport::Concern

  included do
    scope :chronologically, ->(record) {
      scope = order(id: :asc)

      record.present? ? where("#{table_name}.id > ?", record.id) : scope
    }
  end
end
