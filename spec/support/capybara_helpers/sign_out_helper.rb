module CapybaraHelpers
  module SignOutHelper
    def sign_out_as(user)
      within(".first-top-menu") do
        find("span", text: user.username).click
        click_on(I18n.t("sign_out"))
      end
    end
  end
end