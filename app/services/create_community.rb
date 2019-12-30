class CreateCommunity
  include ActiveModel::Model

  attr_reader :community
  attr_accessor :user, :url, :title, :description

  def call
    ActiveRecord::Base.transaction do
      @community = Community.create!(
        url: url,
        title: title,
        description: description
      )

      @community.moderators.create!(user: user)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
