class Communities::UpdateRule
  include ActiveModel::Model

  attr_accessor :rule, :title, :description

  def call
    rule.update!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
