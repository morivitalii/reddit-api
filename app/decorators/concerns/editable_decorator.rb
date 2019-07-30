# frozen_string_literal: true

module EditableDecorator
  extend ActiveSupport::Concern

  included do
    def edited_message
      edited_at = h.datetime_tag(model.edited_at, :ago)

      h.t('edited_html', edited_at: edited_at)
    end
  end
end