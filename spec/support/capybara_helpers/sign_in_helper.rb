module CapybaraHelpers
  module SignInHelper
    def sign_in_as(user)
      visit(root_path)

      click_on(I18n.t("sign_in"))

      within(".new_sign_in_form") do
        fill_in(I18n.t("attributes.username"), with: user.username)
        fill_in(I18n.t("attributes.password"), with: user.password)

        click_on(I18n.t("sign_in"))
      end
    end
  end
end