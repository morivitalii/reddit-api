# frozen_string_literal: true

module Deletable
  extend ActiveSupport::Concern

  included do
    belongs_to :deleted_by, class_name: "User", foreign_key: "deleted_by_id", optional: true

    scope :not_deleted, -> { where(deleted_at: nil) }

    before_update :disapprove_on_delete

    validates :deletion_reason, allow_blank: true, length: { maximum: 5_000 }

    def deletion_reason=(value)
      super(value&.squish)
    end

    def delete!(user, reason = nil)
      update!(
        deleted_by: user,
        deleted_at: Time.current,
        deletion_reason: reason
      )
    end

    def deleted?
      deleted_at.present?
    end

    private

    def deletion?
      deleted_at_changed? && deleted?
    end

    def reset_deletion_attributes
      assign_attributes(
        deleted_by: nil,
        deleted_at: nil,
        deletion_reason: nil
      )
    end

    def disapprove_on_delete
      if deletion?
        reset_approve_attributes
      end
    end
  end
end