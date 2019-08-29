require "rspec/expectations"

RSpec::Matchers.define :have_signed_in_user do |user|
  match do |page|
    page.within(".first-top-menu") do
      expect(page).to have_content(user.username)
    end
  end
  
  failure_message do |_page|
    "expected #{user.username} to be signed in"
  end

  match_when_negated do |page|
    page.within(".first-top-menu") do
      expect(page).to have_content(I18n.t("sign_in"))
    end
  end
  
  failure_message_when_negated do |_page|
    "expected #{user.username} to be signed out"
  end
end
