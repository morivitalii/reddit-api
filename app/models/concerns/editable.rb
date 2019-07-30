# frozen_string_literal: true

module Editable
  extend ActiveSupport::Concern

  included do
    belongs_to :edited_by, class_name: "User", foreign_key: "edited_by_id", optional: true

    before_update :undo_approve_on_edit, if: ->(r) { r.respond_to?(:approvable?) }

    def edit!(user)
      edit(user)
      save!
    end

    def edit(user)
      assign_attributes(
        edited_by: user,
        edited_at: Time.current
      )
    end

    def editable?
      true
    end

    def editing?
      edited_at_changed? && edited?
    end

    def edited?
      edited_at.present?
    end

    private

    def undo_approve_on_edit
      if editing?
        undo_approve
      end
    end
  end
end