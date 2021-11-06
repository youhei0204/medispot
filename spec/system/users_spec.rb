# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }

  before do
    user.confirm
    sign_in_as(user)
  end

  describe 'プロフィール画面の表示' do
    it 'プロフィール画面が表示される' do
      click_link 'マイページ'
      expect(current_path).to eq user_path user
      within '.profile-block' do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
    end
  end

  describe 'プロフィールの更新' do
    before do
      find('#icon').click
      click_link 'プロフィール編集'
    end

    context 'フォームの入力値が正常なとき' do
      it '更新が成功する' do
        fill_in 'user_name', with: 'EditedUser'
        fill_in 'user_introduction', with: 'EditedIntroduction'
        attach_file 'user_image', file_fixture("test_user.png")
        click_button '更新'
        expect(page).to have_content 'プロフィールを更新しました'
        expect(current_path).to eq user_path(user)
        within '.profile-block' do
          expect(page).to have_content 'EditedUser'
          expect(page).to have_content 'EditedIntroduction'
          expect(page).to have_selector("img[src$='test_user.png']")
        end
      end
    end

    context 'ユーザーネームが不正なとき' do
      it '更新が失敗する' do
        fill_in 'user_name', with: 'a' * 31
        fill_in 'user_introduction', with: 'EditedIntroduction'
        click_button '更新'
        expect(page).to have_content '名前は30文字以内で入力してください'
        expect(current_path).to eq user_path(user)
        expect(user.name).to eq user_params[:name]
        expect(user.introduction).to eq user_params[:introduction]
      end
    end
  end
end
