# frozen_string_literal: true

class ThingsSorting
  attr_reader :sorting

  def initialize(sorting = nil)
    @sorting = sorting&.to_sym
  end

  def list
    { hot: I18n.t("hot"), new: I18n.t("new"), top: I18n.t("top"), controversy: I18n.t("controversy") }
  end

  def key
    list.keys.include?(sorting) ? sorting : default_key
  end

  def i18n
    list.fetch(sorting, list[default_key])
  end

  private

  def default_key
    :hot
  end
end