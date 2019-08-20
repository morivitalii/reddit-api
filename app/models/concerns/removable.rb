# frozen_string_literal: true

module Removable
  extend ActiveSupport::Concern

  included do
    belongs_to :removed_by, class_name: "User", foreign_key: "removed_by_id", touch: true, optional: true

    strip_attributes :removed_reason, squish: true

    before_update :undo_approve, if: ->(r) { r.removing? }

    validates :removed_reason, allow_blank: true, length: { maximum: 5_000 }

    def remove!(user, reason = nil)
      remove(user, reason)
      save!
    end

    def remove(user, reason = nil)
      assign_attributes(
        removed_by: user,
        removed_at: Time.current,
        removed_reason: reason
      )
    end

    def undo_remove
      assign_attributes(
        removed_by: nil,
        removed_at: nil,
        removed_reason: nil
      )
    end

    def removable?
      true
    end

    def removing?
      removed_at_changed? && removed?
    end

    def removed?
      removed_at.present?
    end
  end
end