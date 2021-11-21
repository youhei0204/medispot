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
    describe 'プロフィール画面で表示' do
      it 'ライクしたレビューがプロフィール画面に表示されること' do
        visit review_path review.id
        find('.like-btn').click
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

    describe 'レビュー詳細画面で表示' do
      before do
        create_list(:user, 2).each do |user|
          user.likes.create(review_id: review.id)
        end
        visit review_path review.id
        sleep 2
        find('.like-btn').click
        visit current_path
      end

      it 'レビュー詳細画面に"最近ライクしたユーザー"が表示されること' do
        expect(page).to have_content spot.name
        expect(page).to have_content "#{user.name}さんがライクしました。 たった今"
        find('.like-box').hover
      end
      it 'レビュー詳細画面に"ライクしたユーザーの一覧"が表示されること' do
        find('.like-box').hover
        within '.liked-user-box' do
          expect(page).to have_content user.name
          expect(page).to have_content User.last.name
          expect(page).to have_content User.second.name
        end
      end
      it 'レビュー詳細画面の"最近ライクしたユーザー"からプロフィール画面に遷移できること' do
        within '.recent-like-box' do
          click_link "#{user.name}"
        end
        expect(page).to have_current_path(user_path(user))
      end
    end
  end

  describe 'レビューのライクの削除' do
    before { user.likes.create!(review_id: review.id) }

    it '取り消したライクがプロフィール画面で非表示になること' do
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
