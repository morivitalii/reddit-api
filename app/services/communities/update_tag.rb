class Communities::UpdateTag
  include ActiveModel::Model

  attr_accessor :tag, :text

  def call
    tag.update!(
      text: text
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
