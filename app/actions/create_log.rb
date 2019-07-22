# frozen_string_literal: true

class CreateLog
  def initialize(**attributes)
    @attributes = {
      action: attributes[:action],
      sub: attributes[:sub],
      user: attributes[:current_user],
      loggable: attributes[:loggable],
      details: details(attributes[:model], attributes[:attributes])
    }
  end

  def call
    Log.create!(@attributes)
  end

  private

  def details(model = nil, attributes = [])
    return {} if model.blank? || attributes.blank?

    details = {}

    if model.destroyed?
      attributes.each do |attribute|
        details[attribute] = [model[attribute], nil]
      end
    else
      attributes.each do |attribute|
        if model.previous_changes.has_key?(attribute.to_s)
          details[attribute] = model.previous_changes[attribute]
        else
          details[attribute] = [model[attribute], model[attribute]]
        end
      end
    end

    details
  end
end
