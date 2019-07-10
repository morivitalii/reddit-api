# frozen_string_literal: true

class ThingsTypes
  attr_reader :type

  def initialize(type = nil)
    @type = type&.to_sym
  end

  def list
    default_types.merge(types)
  end

  def key
    types.keys.include?(type) ? type.singularize : nil
  end

  def i18n
    list.fetch(type, list[default_key])
  end

  private

  def types
    { posts: I18n.t("posts"), comments: I18n.t("comments") }
  end

  def default_types
    { all: I18n.t("posts_and_comments") }
  end

  def default_key
    :all
  end
end