# frozen_string_literal: true

class SignInPolicy < ApplicationPolicy
  def create?
    visitor?
  end

  alias new? create?
end