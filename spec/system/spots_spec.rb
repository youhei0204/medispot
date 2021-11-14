# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Spot', type: :system do
  let(:user) { create(:user) }
  let(:spot) { create(:spot, :tokyo) }
  let!(:review) { create(:review, :user, spot_id: spot.id, title: 'テストタイトル') }

  before do
    user.confirm
    sign_in_as(user)
  end

  describe 'スポット検索' do
    context '検索条件に合うスポットが存在するとき' do
      before do
        visit user_path user
        fill_in 'header-area', with: '東京'
        fill_in 'header-keyword', with: 'テストタイトル'
        find('.submit-button').click
      end

      it 'スポット詳細画面に検索結果が表示される' do
        expect(current_path).to eq spots_path
        expect(page).to have_content '検索結果：1件'
        within '.spot-box' do
          expect(page).to have_content 'トーキョー'
          expect(page).to have_content '東京都'
          expect(page).to have_content 3.0
        end
      end
    end

    context '検索条件に合うスポットが存在しないとき' do
      before do
        visit user_path user
        fill_in 'header-area', with: 'ニューヨーク'
        fill_in 'header-keyword', with: 'テストタイトル'
        find('.submit-button').click
      end

      it 'スポット詳細画面に検索結果が表示されないこと' do
        expect(current_path).to eq spots_path
        expect(page).to have_content '検索結果：0件'
        boxes = all(:css, 'spot-box')
        expect(boxes.count).to eq 0
      end
    end

    context '条件を入力せずに検索するとき' do
      before do
        visit user_path user
        fill_in 'header-area', with: ''
        fill_in 'header-keyword', with: ''
        find('.submit-button').click
      end

      it '遷移元画面にリダイレクトすること' do
        expect(current_path).to eq(user_path(user))
      end
    end
  end
end
