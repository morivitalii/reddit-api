# frozen_string_literal: true

module Chronological
  extend ActiveSupport::Concern

  included do
    scope :sort_records_chronologically, -> { order(id: :asc) }
    scope :records_after, ->(record) { where("#{table_name}.id > ?", record.id) if record.present? }
  end
end
