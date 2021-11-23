# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }

  before { user.confirm }

  describe 'プロフィール画面の表示' do
    it 'プロフィール画面が表示されること' do
      sign_in_as(user)
      click_link 'マイページ'
      expect(current_path).to eq user_path user
      within '.profile-block' do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
    end
  end

  describe 'プロフィールの更新', js: true do
    describe '非ゲストユーザー' do
      before do
        sign_in_as(user)
        find('#icon').click
        click_link 'プロフィール編集'
      end

      context 'フォームの入力値が正常なとき' do
        it '更新が成功すること' do
          fill_in 'user_name', with: 'EditedUser'
          fill_in 'user_introduction', with: 'EditedIntroduction'
          attach_file 'user_image', file_fixture("test_user.png"), make_visible: true
          click_button '更新'
          sleep 3
          expect(page).to have_content 'プロフィールを更新しました'
          expect(current_path).to eq user_path(user)
          within '.profile-block' do
            expect(page).to have_content 'EditedUser'
            expect(page).to have_content 'EditedIntroduction'
            expect(page).to have_selector("img[src$='test_user.png']")
          end
        end

        context 'ユーザーネームが不正なとき' do
          it '更新が失敗すること' do
            fill_in 'user_name', with: 'a' * 31
            fill_in 'user_introduction', with: 'EditedIntroduction'
            click_button '更新'
            expect(page).to have_content '名前は30文字以内で入力してください'
            expect(current_path).to eq edit_user_path(user)
            expect(user.name).not_to eq 'a' * 31
            expect(user.introduction).not_to eq 'EditedIntroduction'
          end
        end
      end
    end

    describe 'ゲストユーザー' do
      before do
        sign_in_as_guest
        find('#icon').click
        click_link 'プロフィール編集'
      end
      it '更新が失敗すること' do
        fill_in 'user_name', with: 'EditedUser'
        fill_in 'user_introduction', with: 'EditedIntroduction'
        click_button '更新'
        expect(page).to have_content 'ゲストユーザーは変更・削除できません。'
        expect(current_path).to eq root_path
        find('#icon').click
        click_link 'マイページ'
        expect(user.name).not_to eq 'EditedUser'
        expect(user.introduction).not_to eq 'EditedIntroduction'
      end
    end
  end
end
