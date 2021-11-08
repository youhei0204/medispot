# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :system, js: true do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }

  describe 'アカウントの新規作成', js: false do
    before do
      visit root_path
      click_link '新規登録'
    end

    context 'フォームの入力値が正常なとき' do
      it '新規作成が成功する' do
        expect do
          fill_in 'user_name', with: 'user1'
          fill_in 'user_email', with: 'user1@email.com'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録'
          expect(current_path).to eq root_path
          expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        end.to change { User.count }.by(1)
      end
    end

    context 'emailが登録済みのとき' do
      before { user.confirm }

      it '新規作成が失敗する' do
        expect do
          fill_in 'user_name', with: 'user1'
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録'
          expect(current_path).to eq user_registration_path
          expect(page).to have_content 'Eメールはすでに存在します'
        end.to change { User.count }.by(0)
      end
    end
  end

  describe 'アカウント情報の更新' do
    before do
      user.confirm
      sign_in_as(user)
      find('#icon').click
      click_link 'プロフィール編集'
      click_link 'アカウント情報の変更はこちら'
    end

    context 'フォームの入力値が正常なとき' do
      it '更新が成功する' do
        fill_in 'user_email', with: 'edited@email.com'
        fill_in 'user_current_password', with: user_params[:password]
        click_button '更新'
        expect(current_path).to eq root_path
        expect(page).to have_content 'アカウント情報を変更しました'
        expect(user.reload.email).to eq('edited@email.com')
      end
    end

    context 'パスワードが不正なとき' do
      it '更新が失敗する' do
        fill_in 'user_email', with: 'edited@email.com'
        fill_in 'user_current_password', with: 'invalid_password'
        click_button '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '現在のパスワードは不正な値です'
        expect(user.reload.email).not_to eq('edited@email.com')
      end
    end
  end

  describe 'アカウント削除' do
    it '削除に成功する' do
      user.confirm
      sign_in_as(user)
      find('#icon').click
      click_link 'プロフィール編集'
      expect(current_path).to eq edit_user_path user

      click_link 'アカウント情報の変更はこちら'
      expect(current_path).to eq edit_user_registration_path user

      expect do
        click_link '削除する場合はこちら'
        page.accept_confirm '本当に削除しますか？'
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end.to change { User.count }.by(-1)
    end
  end
end
