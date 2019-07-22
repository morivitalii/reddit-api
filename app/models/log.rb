# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :loggable, polymorphic: true, optional: true

  scope :global, -> { where(sub: nil) }

  enum action: [
    :update_sub_settings,
    :create_moderator, :delete_moderator,
    :create_ban, :update_ban, :delete_ban,
    :create_contributor, :delete_contributor,
    :create_rule, :update_rule, :delete_rule,
    :create_deletion_reason, :update_deletion_reason, :delete_deletion_reason,
    :create_tag, :update_tag, :delete_tag,
    :update_thing, :mark_thing_as_approved, :mark_thing_as_deleted,
    :create_page, :update_page, :delete_page,
    :create_blacklisted_domain, :delete_blacklisted_domain
  ]

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
