# frozen_string_literal: true

module ReportableDecorator
  extend ActiveSupport::Concern

  included do
    def report_link
      link_title = h.t('report')
      link_path = [:new, model, :report]
      link_class = "report dropdown-item"

      h.link_to(link_title, link_path, remote: true, class: link_class)
    end

    def reports_link
      link_title = h.t('reports')
      link_path = [model, :reports]
      link_class = "reports dropdown-item"

      h.link_to(link_title, link_path, remote: true, class: link_class)
    end

    def ignore_reports_link
      ignore_reports = model.ignore_reports?
      model_name = model.class.name.camelize(:lower)

      link_title = ignore_reports ? h.fa_icon('check-square-o', text: h.t('ignore_reports')) : h.fa_icon('square-o', text: h.t('ignore_reports'))
      link_class = "ignore_reports dropdown-item"
      link_data_params = "update_#{model_name}[ignore_reports]=#{ignore_reports ? false : true}"
      link_path = [model]

      h.link_to(link_title, link_path, data: { params: link_data_params }, remote: true, method: :put, class: link_class)
    end
  end
end