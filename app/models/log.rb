# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :loggable, polymorphic: true, optional: true

  scope :global, -> { where(sub: nil) }

  enum action: {
    update_sub_settings: 1,
    create_moderator: 2,
    delete_moderator: 4,
    create_ban: 5,
    update_ban: 6,
    delete_ban: 7,
    create_contributor: 8,
    delete_contributor: 9,
    create_rule: 10,
    update_rule: 11,
    delete_rule: 12,
    create_deletion_reason: 13,
    update_deletion_reason: 14,
    delete_deletion_reason: 15,
    create_tag: 16,
    update_tag: 17,
    delete_tag: 18,
    mark_thing_as_approved: 19,
    mark_thing_as_deleted: 20,
    create_page: 26,
    update_page: 27,
    delete_page: 28,
    create_blacklisted_domain: 29,
    delete_blacklisted_domain: 30,
    update_thing: 31
  }

  def self.model_changes(model, action)
    changes = {}

    attributes = case action
                 when :update_sub_settings
                   [:title, :description]
                 when :create_moderator
                   []
                 when :delete_moderator
                   []
                 when :create_ban
                   [:reason, :days, :permanent]
                 when :update_ban
                   [:reason, :days, :permanent]
                 when :delete_ban
                   [:reason, :days, :permanent]
                 when :create_contributor
                   []
                 when :delete_contributor
                   []
                 when :create_rule
                   [:title, :description]
                 when :update_rule
                   [:title, :description]
                 when :delete_rule
                   [:title, :description]
                 when :create_deletion_reason
                   [:title, :description]
                 when :update_deletion_reason
                   [:title, :description]
                 when :delete_deletion_reason
                   [:title, :description]
                 when :create_tag
                   [:title]
                 when :update_tag
                   [:title]
                 when :delete_tag
                   [:title]
                 when :mark_thing_as_approved
                   [:approved, :deleted, :deletion_reason, :text]
                 when :mark_thing_as_deleted
                   [:deleted, :deletion_reason, :approved, :text]
                 when :create_page
                   [:title, :text]
                 when :update_page
                   [:title, :text]
                 when :delete_page
                   [:title, :text]
                 when :create_blacklisted_domain
                   [:domain]
                 when :delete_blacklisted_domain
                   [:domain]
                 when :update_thing
                   [:receive_notifications, :explicit, :spoiler, :tag, :ignore_reports]
                 end

    if model.destroyed?
      attributes.each do |attribute|
        changes[attribute] = [model[attribute], nil]
      end
    else
      attributes.each do |attribute|
        if model.previous_changes.has_key?(attribute.to_s)
          changes[attribute] = model.previous_changes[attribute]
        else
          changes[attribute] = [model[attribute], model[attribute]]
        end
      end
    end

    changes
  end

  def html_details
    return @html_text if defined? (@html_text)

    @html_text = ""
    helpers = ApplicationController.helpers

    details.each do |attribute, (from, to)|
      if (from.present? || to.present?) && from != to
        @html_text += helpers.content_tag("div",
          helpers.content_tag("div", ActiveRecord::Base.human_attribute_name(attribute), class: "col-12") +
              helpers.content_tag("div", Diffy::Diff.new(from, to).to_s(:html).html_safe, class: "col-12 mt-2 mb-2"),
        class: "row")
      end
    end

    @html_text
  end
end
