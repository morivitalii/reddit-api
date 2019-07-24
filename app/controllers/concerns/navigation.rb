# frozen_string_literal: true

module Navigation
  extend ActiveSupport::Concern

  included do
    before_action do
      @navigation = Rails.cache.fetch("user-navigation-#{current_user&.id}-#{current_user&.updated_at}", expires_in: 24.hours) do
        navigation = {
          other: {
            items: [
              { href: root_path, title: t("home") },
            ]
          }
        }

        if helpers.user_signed_in?
          navigation[:other][:items].push({ href: notifications_path, title: t("notifications") })
          navigation[:other][:items].push({ href: edit_users_path, title: t("settings") })

          moderator_in = Sub.joins(:moderators).where(moderators: { user: current_user }).to_a
          follower_in = Sub.joins(:follows).where(follows: { user: current_user }).to_a
          follower_in.reject! { |i| i.in?(moderator_in) }

          if moderator_in.present?
            navigation[:moderator_in] = {
              title: t("mod_queue"),
              items: [{ href: mod_queues_path, title: t("mod_queue") }] +
                     moderator_in.map { |sub| { href: sub_path(sub), title: sub.title } }
            }
          end

          if follower_in.present?
            navigation[:follower_in] = {
              title: t("follows"),
              items: follower_in.map { |sub| { href: sub_path(sub), title: sub.title } }
            }
          end
        end

        navigation
      end
    end
  end
end
