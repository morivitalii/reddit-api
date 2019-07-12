# frozen_string_literal: true

class ModQueuesTypes
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
    { not_approved: I18n.t("new"), reported: I18n.t("reports") }
  end

  def default_types
    { all: I18n.t("all") }
  end

  def default_key
    :all
  end
end