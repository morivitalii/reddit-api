# frozen_string_literal: true

module Deletable
  extend ActiveSupport::Concern

  included do
    belongs_to :deleted_by, class_name: "User", foreign_key: "deleted_by_id", optional: true

    scope :not_deleted, -> { where(deleted_at: nil) }

    after_update :delete_reports_on_delete

    before_update :disapprove_on_delete
    after_update :update_comment_in_topic_on_delete

    def deletion_reason=(value)
      super(value&.squish)
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

    def update_comment_in_topic_on_delete
      return unless comment?
      return unless deleted_at_previously_changed?

      ActiveRecord::Base.connection.execute(
          "UPDATE topics SET branch = jsonb_set(branch, '{#{id}, deleted}', '#{deleted?}', false), updated_at = '#{Time.current.strftime('%Y-%m-%d %H:%M:%S.%N')}' WHERE post_id = #{post_id};"
      )
    end

    def delete_reports_on_delete
      if deletion?
        reports.destroy_all
      end
    end
  end
end