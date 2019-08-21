# frozen_string_literal: true

class Context
  attr_accessor :user, :community

  def initialize(user, community = nil)
    @user = user
    @community = community
  end
end