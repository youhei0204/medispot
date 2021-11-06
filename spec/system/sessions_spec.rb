# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let!(:user) { create(:user).confirm }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_password) { 'invalid_password' }

  before do
    visit root_path
    expect(page).to have_http_status :ok
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
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
