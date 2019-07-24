# frozen_string_literal: true

module Editable
  extend ActiveSupport::Concern

  included do
    belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id", optional: true

    def edited?
      edited_at.present?
    end

    private

    def editing?
      edited_at_changed? && edited?
    end
  end
end