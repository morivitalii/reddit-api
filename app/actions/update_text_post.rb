# frozen_string_literal: true

class UpdateTextPost
  include ActiveModel::Model

  attr_accessor :post, :text

  def save!
    @post.update!(text: @text)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    raise ActiveModel::ValidationError.new(self)
  end
end
