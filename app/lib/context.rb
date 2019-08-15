# frozen_string_literal: true

class Context
  attr_reader :user, :community

  def initialize(user, community = nil)
    @user = user
    @community = community
  end
end