# frozen_string_literal: true

class VotesTypes
  attr_reader :type

  def initialize(type = nil)
    @type = type&.to_sym
  end

  def list
    default_types.merge(types)
  end

  def key
    types.keys.include?(type) ? type : nil
  end

  def i18n
    list.fetch(type, list[default_key])
  end

  private

  def types
    { ups: I18n.t("ups"), downs: I18n.t("downs") }
  end

  def default_types
    { all: I18n.t("ups_and_downs") }
  end

  def default_key
    :all
  end
end