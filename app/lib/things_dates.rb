# frozen_string_literal: true

class ThingsDates
  attr_reader :range

  def initialize(range = nil)
    @range = range&.to_sym
  end

  def list
    default_ranges.merge(ranges)
  end

  def date
    case range
      when :day then 1.day.ago
      when :week then 1.week.ago
      when :month then 1.month.ago
      else nil
    end
  end

  def i18n
    list.fetch(range, list[default_key])
  end

  private

  def ranges
    { day: I18n.t("day"), week: I18n.t("week"), month: I18n.t("month") }
  end

  def default_ranges
    { all: I18n.t("all_time") }
  end

  def default_key
    :all
  end
end