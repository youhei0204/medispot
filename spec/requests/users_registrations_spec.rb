# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, email: 'invalid_email') }
  let!(:user_num) { User.count }

  describe 'GET /users/sign_up' do
    it 'ユーザ登録画面の表示に成功すること' do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users/sign_up' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    context 'パラメータが正常なとき' do
      before do
        post user_registration_path, params: { user: user_params }
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'ユーザが作成されること' do
        expect(User.count).to eq user_num + 1
      end

      it 'リダイレクトされること' do
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正なとき' do
      before do
        post user_registration_path, params: { user: invalid_user_params }
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end

      it 'エラーが表示されること' do
        expect(response.body).to include 'Eメールは不正な値です'
      end

      it '認証メールが送信されないこと' do
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'ユーザが作成されないこと' do
        expect(User.count).to eq user_num
      end
    end
  end
end
