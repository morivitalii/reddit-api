class Communities::CreateRule
  include ActiveModel::Model

  attr_accessor :community, :title, :description
  attr_reader :rule

  def call
    @rule = community.rules.create!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
