# frozen_string_literal: true

module Reportable
  extend ActiveSupport::Concern

  included do
    has_many :reports

    after_update :delete_reports_on_approve
    after_update :delete_reports_on_delete

    private

    def delete_reports_on_approve
      if approving?
        reports.destroy_all
      end
    end

    def delete_reports_on_delete
      if deletion?
        reports.destroy_all
      end
    end
  end
end