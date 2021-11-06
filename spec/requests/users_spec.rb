# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'other@test.com') }
  let(:user_params) { attributes_for(:user) }

  before do
    user.confirm
  end
  describe 'GET /users' do
    before do
      sign_in user
      get user_path user
    end
    it 'プロフィール画面の表示に成功すること' do
      expect(response).to have_http_status(:success)
    end
    it 'プロフィール情報が表示されること' do
      expect(response.body).to include user.name
      expect(response.body).to include user.introduction
    end
  end

  describe 'GET /edit' do
    context 'ログイン済みのとき' do
      before do
        sign_in user
        get edit_user_path user
      end
      it 'プロフィール編集画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it 'フォームにプロフィール情報が表示されること' do
        expect(response.body).to include user.name
        expect(response.body).to include user.introduction
      end
    end
    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされること' do
        get edit_user_path user
        expect(response).to redirect_to new_user_session_path
      end
    end
    context '他ユーザの画面にアクセスするとき' do
      it 'トップページにリダイレクトされること' do
        sign_in user
        get edit_user_path other_user
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PUTCH /users' do
    before { sign_in user }
    context 'パラメータが正常なとき' do
      before do
        user_params[:name] = 'NewName'
        user_params[:introduction] = 'NewIntroduction'
        patch user_path(user), params: { user: user_params }
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'ユーザー情報が更新されること' do
        expect(user.reload.name).to eq 'NewName'
        expect(user.reload.introduction).to eq 'NewIntroduction'
      end
      it 'プロフィール画面にリダイレクトされること' do
        expect(response).to redirect_to user_path(user)
      end
    end
    context 'パラメータが不正なとき' do
      before do
        user_params[:name] = ''
        patch user_path(user), params: { user: user_params }
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'エラーが表示されること' do
        expect(response.body).to include '名前を入力してください'
      end
      it 'ユーザー情報が更新されないこと' do
        expect(user.reload.name).to eq 'testuser1'
      end
    end
  end
end
