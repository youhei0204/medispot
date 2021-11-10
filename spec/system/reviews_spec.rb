# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :system, js: true do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let!(:review) { create(:review, :spot, user_id: user.id) }

  before do
    user.confirm
    sign_in_as(user)
  end

  describe 'レビューの新規作成' do
    before do
      visit root_path
      click_link '投稿'
      fill_in 'keyword', with: '東京スカイツリー'
      click_button '検索'
      find('.spot-dicision').click
    end

    context 'フォームの入力値が正常なとき' do
      before do
        fill_in 'review_title', with: 'title1'
        fill_in 'review_content', with: 'content1'
        attach_file 'img-file',
          [
            file_fixture("test_review1.png"),
            file_fixture("test_review2.png"),
          ],
          make_visible: true
        find('#star').find("img[alt='3']").click
        click_button '投稿'
      end

      it '新規作成が成功し、プロフィール画面に内容が表示される' do
        expect(page).to have_current_path(user_path(user))
        expect(page).to have_content '投稿が完了しました'
        within '#review_prev' do
          expect(page).to have_content '東京スカイツリー'
          expect(page).to have_content 'title1'
          expect(page).to have_content 'content1'
          expect(page).to have_content 3.0
          expect(page).to have_selector("img[src$='test_review1.png']")
        end
      end
      it '新規作成が成功し、レビュー詳細画面に内容が表示される' do
        expect(page).to have_current_path(user_path(user))
        expect(page).to have_content '投稿が完了しました'
        visit(review_path(Review.last))
        within '.main-block' do
          expect(page).to have_content 'title1'
          expect(page).to have_content 'content1'
          expect(page).to have_content 3.0
          expect(page).to have_selector("img[src$='test_review1.png']")
          expect(page).to have_selector("img[src$='test_review2.png']")
        end
      end
      it '新規作成が成功し、スポット詳細画面に内容が表示される' do
        expect(page).to have_current_path(user_path(user))
        expect(page).to have_content '投稿が完了しました'
        visit(spot_path(Review.last.spot))
        within '.review-box' do
          expect(page).to have_content 'title1'
          expect(page).to have_content 'content1'
          expect(page).to have_content 3.0
          expect(page).to have_selector("img[src$='test_review1.png']")
        end
      end
    end

    context 'フォームの本文が空のとき' do
      it '新規作成が失敗する' do
        expect do
          fill_in 'review_content', with: ''
          click_button '投稿'
        end.to change { Review.count }.by(0)
      end
    end
  end

  describe 'レビューの更新' do
    before do
      visit root_path
      click_link '投稿'
      fill_in 'keyword', with: '東京スカイツリー'
      click_button '検索'
      find('.spot-dicision').click
      fill_in 'review_title', with: 'title1'
      fill_in 'review_content', with: 'content1'
      attach_file 'img-file', file_fixture("test_review1.png"), make_visible: true
      find('#star').find("img[alt='3']").click
      click_button '投稿'
    end

    context 'フォームの入力値が正常なとき' do
      it '更新が成功し、レビュー詳細画面に内容が表示される' do
        click_link '編集', match: :first
        fill_in 'review_title', with: 'updated_title1'
        fill_in 'review_content', with: 'updated_content1'
        attach_file 'img-file', file_fixture("test_review2.png"), make_visible: true
        find('#star').find("img[alt='4']").click
        click_button '更新'
        expect(page).to have_current_path(user_path(user))
        expect(page).to have_content 'レビューを更新しました'

        visit review_path(Review.last)
        within '.main-block' do
          expect(page).to have_content 'updated_title1'
          expect(page).to have_content 'updated_content1'
          expect(page).to have_content 4.0
          expect(page).to have_selector("img[src$='test_review1.png']")
          expect(page).to have_selector("img[src$='test_review2.png']")
        end
      end
    end

    context 'フォームの入力値が正常かつ既存の画像を削除するとき' do
      it '更新が成功し、レビュー詳細画面に内容が表示される' do
        click_link '編集', match: :first
        fill_in 'review_title', with: 'updated_title1'
        fill_in 'review_content', with: 'updated_content1'
        find('.initial-image-delete').click
        find('#star').find("img[alt='4']").click
        click_button '更新'
        expect(page).to have_current_path(user_path(user))
        expect(page).to have_content 'レビューを更新しました'

        visit review_path(Review.last)
        within '.main-block' do
          expect(page).to have_content 'updated_title1'
          expect(page).to have_content 'updated_content1'
          expect(page).to have_content 4.0
          expect(page).not_to have_selector("img[src$='test_review1.png']")
        end
      end
    end

    context 'フォームの本文が空のとき' do
      it '更新が失敗する' do
        fill_in 'review_content', with: ''
        click_button '投稿'
        expect(page).to have_content '本文を入力してください'
      end
    end
  end

  describe 'レビューの削除', js: true do
    before do
      visit user_path user
      click_link '詳細'
    end

    it '削除に成功する' do
      expect do
        click_link '削除'
        page.accept_confirm '本当に削除しますか？'
        expect(page).to have_content 'レビューを削除しました'
      end.to change { Review.count }.by(-1)
    end
  end
end
