require "rails_helper"

RSpec.feature "GET /home" do
  background do
    visit home_pages_home_path
  end

  scenario "move home page from header logo" do
    click_link "header-logo"
    expect(current_path).to eq home_pages_home_path
  end
end
