class Communities::Posts::UpdateForm
  include ActiveModel::Model

  attr_accessor :post, :user, :text

  def save
    post.text = text
    post.edit(user)
    post.update!(text: text)
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
