# frozen_string_literal: true

class CreateModeratorForm
  include ActiveModel::Model

  attr_accessor :community, :username
  attr_reader :moderator

  def save
    @moderator = Moderator.create!(
      community: community,
      user: user
    )
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  def persisted?
    false
  end

  private

  def user
    @_user = UsersQuery.new.with_username(username).take
  end
end
