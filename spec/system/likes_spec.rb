# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let!(:review) { create(:review, spot_id: spot.id, user_id: user.id) }

  before do
    user.confirm
    sign_in_as(user)
  end

  describe 'レビューのライク' do
    it 'ライクしたレビューをプロフィール画面で表示する' do
      visit review_path review.id
      expect(find('.like-count')['innerHTML']).to eq '0'
      find('.like-btn').click
      expect(find('.like-count')['innerHTML']).to eq '1'
      find('#icon').click
      click_link 'マイページ'
      sleep 3
      find('#like_tab').click
      expect(page).to have_content spot.name
      expect(page).to have_content review.title
      expect(page).to have_content review.content
      expect(page).to have_content review.rate
    end
  end

  describe 'レビューのライクの削除' do
    before { user.likes.create!(review_id: review.id) }

    it 'レビューのライクを解除してプロフィール画面で非表示にする' do
      visit review_path review.id
      expect(find('.like-count')['innerHTML']).to eq '1'
      find('.like-btn').click
      expect(find('.like-count')['innerHTML']).to eq '0'
      find('#icon').click
      click_link 'マイページ'
      sleep 3
      find('#like_tab').click
      expect(page).not_to have_content spot.name
      expect(page).not_to have_content review.title
      expect(page).not_to have_content review.content
      expect(page).not_to have_content review.rate
    end
  end
end
