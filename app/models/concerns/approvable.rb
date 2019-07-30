# frozen_string_literal: true

module Approvable
  extend ActiveSupport::Concern

  included do
    belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", optional: true

    before_create :approve_on_create
    before_update :undo_remove_on_approve, if: ->(r) { r.respond_to?(:removable?) }

    def approve!(user)
      approve(user)
      save!
    end

    def approve(user)
      assign_attributes(
        approved_by: user,
        approved_at: Time.current
      )
    end

    def undo_approve!
      undo_approve
      save!
    end

    def undo_approve
      assign_attributes(
        approved_by: nil,
        approved_at: nil
      )
    end

    def approvable?
      true
    end

    def approving?
      approved_at_changed? && approved?
    end

    def approved?
      approved_at.present?
    end

    private

    def approve_on_create
      if auto_approve?
        approve(user)
      end
    end

    def undo_remove_on_approve
      if approving?
        undo_remove
      end
    end

    def auto_approve?
      user.moderator?(sub) || user.contributor?(sub)
    end
  end
end