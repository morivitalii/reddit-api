# frozen_string_literal: true

module ReverseChronological
  extend ActiveSupport::Concern

  included do
    scope :sort_records_reverse_chronologically, -> { order(id: :desc) }
    scope :records_after, ->(record) { where("#{table_name}.id < ?", record.id) if record.present? }
  end
end
