# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users::Sessions', type: :feature do
  let!(:user) { create(:user).confirm }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_password) { 'wrong_password' }

  scenario '正常なパスワードでログインする' do
    visit root_path
    expect(page).to have_http_status :ok

    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path

    fill_in 'user_email', with: user_params[:email]
    fill_in 'user_password', with: user_params[:password]
    click_button 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ログインしました。'
  end
  scenario '誤ったパスワードでログインする' do
    visit root_path
    expect(page).to have_http_status :ok

    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path

    fill_in 'user_email', with: user_params[:email]
    fill_in 'user_password', with: invalid_password
    click_button 'ログイン'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Eメール もしくはパスワードが不正です。'
  end
end
