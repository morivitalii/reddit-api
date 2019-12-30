class UpdateCommunity
  include ActiveModel::Model

  attr_accessor :community, :title, :description

  def call
    community.update!(
      title: title,
      description: description
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
