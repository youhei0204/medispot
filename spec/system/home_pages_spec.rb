# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  before do
    visit home_pages_home_path
  end

  it 'ヘッダーロゴからホームページに遷移する' do
    click_link 'header-logo'
    expect(current_path).to eq root_path
  end
end
