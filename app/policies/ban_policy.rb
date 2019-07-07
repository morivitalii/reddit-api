# frozen_string_literal: true

class BanPolicy < ApplicationPolicy
  def index?
    staff?
  end

  alias search? index?
  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias confirm? index?
  alias destroy? index?
end
