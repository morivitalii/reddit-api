class Communities::UpdatePost
  include ActiveModel::Model

  attr_accessor :post, :edited_by, :text

  def call
    post.update!(
      text: text,
      edited_by: edited_by,
      edited_at: Time.current
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
