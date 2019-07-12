# frozen_string_literal: true

module Sorting
  extend ActiveSupport::Concern

  included do
    scope :chronologically, ->(record) {
      scope = order(id: :asc)

      record.present? ? where("#{table_name}.id > ?", record.id) : scope
    }

    scope :reverse_chronologically, ->(record) {
      scope = order(id: :desc)

      record.present? ? scope.where("#{table_name}.id < ?", record.id) : scope
    }
  end
end
