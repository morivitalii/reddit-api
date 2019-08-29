require "rails_helper"

RSpec.describe "User creates community ban", type: :system do
  context "with form filled by invalid data" do
    it "see errors in form" do
      moderator_user = create(:user)
      community = create(:community_with_user_moderator, user: moderator_user)

      sign_in_as(moderator_user)
      visit(community_bans_path(community))
      open_and_submit_create_ban_form_with("invalid_username")

      expect(page).to have_form_errors_on(".new_create_ban_form")
    end
  end

  context "with form filled by valid data" do
    it "successfully creates ban" do
      moderator_user = create(:user)
      community = create(:community_with_user_moderator, user: moderator_user)
      user_to_ban = create(:user)

      sign_in_as(moderator_user)
      visit(community_bans_path(community))
      open_and_submit_create_ban_form_with(user_to_ban.username)

      within("#bans") do
        expect(page).to have_content(user_to_ban.username)
      end
    end
  end

  def open_and_submit_create_ban_form_with(username)
    within(".actions") do
      click_on(I18n.t("create"))
    end

    within(".new_create_ban_form") do
      fill_in(I18n.t("attributes.username"), with: username)
      check(I18n.t("attributes.permanent"), allow_label_click: true)

      click_on(I18n.t("create"))
    end
  end
end