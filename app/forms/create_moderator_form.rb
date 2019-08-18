# frozen_string_literal: true

class CreateModeratorForm
  include ActiveModel::Model

  attr_accessor :community, :username
  attr_reader :moderator

  def save
    return false if invalid?

    user = UsersQuery.new.with_username(username).take!

    @moderator = Moderator.create!(
      community: community,
      user: user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    return false
  end
end
