require "rails_helper"

RSpec.describe "User creates ban", type: :system do
  context "with form filled by invalid data" do
    it "shows errors" do
      moderator_user = create(:user)
      community = create(:community_with_user_moderator, user: moderator_user)

      login_as(moderator_user)
      visit(community_bans_path(community))
      open_and_submit_create_ban_form_with("invalid_username")

      expect(page).to have_form_errors_on(".new_create_ban_form")
    end
  end

  context "with form filled by valid data" do
    it "creates ban" do
      moderator_user = create(:user)
      community = create(:community_with_user_moderator, user: moderator_user)
      user_to_ban = create(:user)

      login_as(moderator_user)
      visit(community_bans_path(community))
      open_and_submit_create_ban_form_with(user_to_ban.username)

      within("#bans") do
        expect(page).to have_content(user_to_ban.username)
      end
    end
  end

  def open_and_submit_create_ban_form_with(username)
    within("#bans .head") do
      click_link(I18n.t("create"))
    end

    within(".new_create_ban_form") do
      fill_in(I18n.t("attributes.username"), with: username)
      check(I18n.t("attributes.permanent"), allow_label_click: true)

      click_button(I18n.t("create"))
    end
  end
end