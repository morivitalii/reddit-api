# frozen_string_literal: true

class Log < ApplicationRecord
  include Paginatable

  belongs_to :sub, optional: true
  belongs_to :user
  belongs_to :loggable, polymorphic: true, optional: true

  scope :global, -> { where(sub: nil) }

  enum action: {
      update_sub_settings: "update_sub_settings",
      create_moderator: "create_moderator",
      delete_moderator: "delete_moderator",
      create_ban: "create_ban",
      update_ban: "update_ban",
      delete_ban: "delete_ban",
      create_contributor: "create_contributor",
      delete_contributor: "delete_contributor",
      create_rule: "create_rule",
      update_rule: "update_rule",
      delete_rule: "delete_rule",
      create_deletion_reason: "create_deletion_reason",
      update_deletion_reason: "update_deletion_reason",
      delete_deletion_reason: "delete_deletion_reason",
      create_tag: "create_tag",
      update_tag: "update_tag",
      delete_tag: "delete_tag",
      update_thing: "update_thing",
      mark_thing_as_approved: "mark_thing_as_approved",
      mark_thing_as_deleted: "mark_thing_as_deleted",
      create_page: "create_page",
      update_page: "update_page",
      delete_page: "delete_page",
      create_blacklisted_domain: "create_blacklisted_domain",
      delete_blacklisted_domain: "delete_blacklisted_domain"
  }

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
