require "rspec/expectations"

RSpec::Matchers.define :have_form_errors_on do |form_selector|
  match do |page|
    page.within(form_selector) do
      expect(page).to have_css("span.text-danger")
    end
  end

  failure_message do |_page|
    "expected form#{form_selector} to have errors"
  end

  match_when_negated do |page|
    page.within(form_selector) do
      expect(page).to_not have_css("span.text-danger")
    end
  end

  failure_message_when_negated do |_page|
    "expected form#{form_selector} to not have errors"
  end
end
