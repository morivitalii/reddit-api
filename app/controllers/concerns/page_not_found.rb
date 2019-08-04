# frozen_string_literal: true

module PageNotFound
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

    def page_not_found
      if request.xhr?
        head :not_found
      else
        render "page_not_found/show", status: :not_found
      end
    end
  end
end
