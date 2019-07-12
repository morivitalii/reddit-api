# frozen_string_literal: true

module ReverseChronological
  extend ActiveSupport::Concern

  included do
    scope :reverse_chronologically, ->(record) {
      scope = order(id: :desc)

      record.present? ? scope.where("#{table_name}.id < ?", record.id) : scope
    }
  end
end
