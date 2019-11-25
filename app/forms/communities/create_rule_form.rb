class Communities::CreateRuleForm
  include ActiveModel::Model

  attr_accessor :community, :title, :description
  attr_reader :rule

  def save
    @rule = community.rules.create!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
