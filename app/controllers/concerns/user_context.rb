# frozen_string_literal: true

class UserContext
  attr_reader :user, :sub

  def initialize(user, sub = nil)
    @user = user
    @sub = sub
  end
end