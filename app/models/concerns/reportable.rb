# frozen_string_literal: true

module Reportable
  extend ActiveSupport::Concern

  included do
    has_many :reports, as: :reportable, dependent: :destroy

    after_update :delete_reports, if: ->(r) { r.approving? }
    after_update :delete_reports, if: ->(r) { r.respond_to?(:removable?) && removing? }

    def reportable?
      true
    end

    private

    def delete_reports
      reports.destroy_all
    end
  end
end