class Communities::CreateTag
  include ActiveModel::Model

  attr_accessor :community, :text
  attr_reader :tag

  def call
    @tag = community.tags.create!(
      text: text
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
