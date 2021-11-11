# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites', type: :system, js: true do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let!(:review) { create(:review, spot_id: spot.id, user_id: user.id) }

  before do
    user.confirm
    sign_in_as(user)
  end

  describe 'スポットの保存' do
    it '保存したスポットをプロフィール画面で表示する' do
      visit spot_path spot.id
      find('.favorite-btn').click
      find('#icon').click
      click_link 'マイページ'
      sleep 3
      find('#favorite_tab').click
      expect(page).to have_content spot.name
      expect(page).to have_content spot.address
      expect(page).to have_content spot.average_rate
    end
  end

  describe 'スポットの保存の解除' do
    before { user.favorites.create!(spot_id: spot.id) }

    it 'スポットの保存を解除してプロフィール画面で非表示にする' do
      visit spot_path spot.id
      find('.favorite-btn').click
      find('#icon').click
      click_link 'マイページ'
      sleep 3
      find('#favorite_tab').click
      expect(page).not_to have_content spot.name
      expect(page).not_to have_content spot.address
      expect(page).not_to have_content spot.average_rate
    end
  end
end
