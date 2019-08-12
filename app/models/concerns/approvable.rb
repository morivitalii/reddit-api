# frozen_string_literal: true

module Approvable
  extend ActiveSupport::Concern

  included do
    belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id", optional: true

    before_create -> { approve(user) }, if: -> (r) { r.auto_approve? }
    before_update :undo_remove, if: ->(r) { r.respond_to?(:removable?) && r.approving? }

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

    def auto_approve?
      context = Context.new(user, sub)
      Pundit.policy(context, self).approve?
    end
  end
end