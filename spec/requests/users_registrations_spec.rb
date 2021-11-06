# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  let(:user) { create(:user) }
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
      it 'nameカラムに値が存在すること' do
        expect(User.last.name).to eq user_params[:name]
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

  describe 'PUTCH /users' do
    before do
      user.confirm
      sign_in user
    end
    context 'パラメータが正常なとき' do
      before do
        updated_user_params = { current_password: user_params[:password], email: 'updated@test.com' }
        patch user_registration_path, params: { user: updated_user_params }
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'アカウント情報が更新されること' do
        expect(user.reload.email).to eq 'updated@test.com'
      end
      it 'トップページにリダイレクトされること' do
        expect(response).to redirect_to root_path
      end
    end
    context 'パラメータが不正なとき' do
      before do
        updated_user_params = { current_password: 'invalid_password', email: 'updated@test.com' }
        patch user_registration_path, params: { user: updated_user_params }
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'アカウント情報が更新されないこと' do
        expect(user.reload.email).to eq user_params[:email]
      end
      it 'エラーが表示されること' do
        expect(response.body).to include '現在のパスワードは不正な値です'
      end
    end
  end

  describe 'DELETE /users' do
    before do
      user.confirm
      sign_in user
      delete user_registration_path
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 302
    end
    it 'アカウントが削除されること' do
      expect(User.find_by(id: user.id)).to be nil
    end
    it 'トップページにリダイレクトされること' do
      expect(response).to redirect_to root_path
    end
  end
end
