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
    it 'ログインに成功し、直前のページにリダイレクトされること' do
      visit root_path
      click_link review.title
      click_link 'ゲストとしてログイン'
      expect(current_path).to eq review_path review
      expect(page).to have_content 'ゲストとしてログインしました。'
    end
  end
end
