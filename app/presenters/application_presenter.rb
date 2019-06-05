# frozen_string_literal: true

class ApplicationPresenter < SimpleDelegator
  private

  def helpers
    ApplicationController.helpers
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
