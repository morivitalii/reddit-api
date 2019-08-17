# frozen_string_literal: true

class PageNotFoundPolicy < ApplicationPolicy
  def show?
    true
  end
end