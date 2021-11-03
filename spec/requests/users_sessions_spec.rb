# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  let!(:user) { create(:user).confirm }
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
        post user_session_path, params: { user: user_params }
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end

      it 'リダイレクトされること' do
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
end
