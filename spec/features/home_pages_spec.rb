# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'HomePages' do
  background do
    visit home_pages_home_path
  end

  scenario 'ヘッダーロゴからホームページに遷移する' do
    click_link 'header-logo'
    expect(current_path).to eq root_path
  end
end
