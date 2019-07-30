# frozen_string_literal: true

module Reportable
  extend ActiveSupport::Concern

  included do
    has_many :reports, as: :reportable, dependent: :destroy

    after_update :delete_reports_on_approve, if: ->(r) { r.respond_to?(:approvable?) }
    after_update :delete_reports_on_remove, if: ->(r) { r.respond_to?(:removable?) }

    def reportable?
      true
    end

    private

    def delete_reports_on_approve
      if approving?
        reports.destroy_all
      end
    end

    def delete_reports_on_remove
      if removing?
        reports.destroy_all
      end
    end
  end
end