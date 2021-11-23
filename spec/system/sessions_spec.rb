# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { User.create(user_params) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_password) { 'invalid_password' }
  let!(:review) { create(:review, :user, :spot, title: 'テストタイトル') }

  describe 'ゲスト以外のユーザーでログイン' do
    before do
      user.confirm
      visit root_path
      click_link 'ログイン'
    end

    context 'パスワードが正常なとき' do
      it 'ログインに成功する' do
        fill_in 'user_email', with: user_params[:email]
        fill_in 'user_password', with: user_params[:password]
        click_button 'ログイン'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'パスワードが不正なとき' do
      it 'ログインに失敗する' do
        fill_in 'user_email', with: user_params[:email]
        fill_in 'user_password', with: invalid_password
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Eメール もしくはパスワードが不正です。'
      end
    end
  end

  describe 'ゲストユーザーとしてログイン' do
    context 'ゲストユーザー数が5未満のとき' do
      before do
        4.times do
          sign_in_as_guest
          logout
        end
        visit root_path
        click_link review.title
      end

      it 'ログインに成功し、直前のページにリダイレクトされること' do
        click_link 'ゲストとしてログイン'
        expect(current_path).to eq review_path review
        expect(page).to have_content 'ゲストとしてログインしました。'
      end
      it 'ゲストユーザーが新たに作成されること' do
        expect do
          click_link 'ゲストとしてログイン'
        end.to change { User.where("email like 'guest_%@medispot.com'").count }.by(1)
      end
    end

    context 'ゲストユーザー数が5(最大数)のとき' do
      before do
        5.times do
          sign_in_as_guest
          sleep 1
          logout
        end
        visit root_path
        click_link review.title
      end

      it 'ログインに成功し、直前のページにリダイレクトされること' do
        click_link 'ゲストとしてログイン'
        expect(current_path).to eq review_path review
        expect(page).to have_content 'ゲストとしてログインしました。'
      end
      it '最終ログインの古いゲストにログインすること' do
        click_link 'ゲストとしてログイン'
        find('#icon').click
        click_link 'マイページ'
        expect(page).to have_content 'ゲスト(赤)'
        expect(page).to have_content 'ゲスト(赤)としてログインしています。'
      end
    end
  end
end
