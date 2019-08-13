# frozen_string_literal: true

class ReportPolicy < ApplicationPolicy
  def posts?
    user_signed_in? && user_moderator?
  end

  alias comments? posts?

  def show?
    user_signed_in? && user_moderator?
  end

  def create?
    user_signed_in?
  end

  alias new? create?

  def permitted_attributes_for_create
    [:text]
  end
end
