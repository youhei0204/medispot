# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  let(:user) { User.create(user_params) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, email: 'incorrect@test.com') }

  describe 'GET /users/sign_in' do
    it 'ログイン画面の表示に成功すること' do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users/sign_in' do
    context 'パラメータが正常なとき' do
      before do
        user.confirm
        post user_session_path, params: { user: user_params }
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'ホームページにリダイレクトされること' do
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      before do
        post user_session_path, params: { user: invalid_user_params }
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'エラーが表示されること' do
        expect(response.body).to include 'Eメール もしくはパスワードが不正です。'
      end
    end
  end

  describe 'POST /users/guest_sign_in' do
    context 'ゲストユーザーが存在するとき' do
      before do
        create(:user, :guest)
        post users_guest_sign_in_path
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'ホームページにリダイレクトされること' do
        expect(response).to redirect_to root_url
      end
    end

    context 'ゲストユーザーが存在しないとき' do
      before do
        post users_guest_sign_in_path
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'ゲストユーザーが作成されること' do
        expect(User.find_by(email: 'guest@medispot.com').present?).to be true
      end
      it 'ホームページにリダイレクトされること' do
        expect(response).to redirect_to root_url
      end
    end
  end
end
