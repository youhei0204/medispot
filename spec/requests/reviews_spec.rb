require 'rails_helper'

RSpec.describe 'Review', type: :request do
  let(:user) { create(:user) }
  let(:review) { create(:review, user_id: user.id) }
  let(:other_review) { create(:review, :user) }

  before { user.confirm }

  describe 'GET /reviews' do
    context 'ログイン済みのとき' do
      before do
        sign_in user
        get review_path review
      end

      it 'レビュー詳細画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it 'レビュー情報が表示されること' do
        expect(response.body).to include review.title
        expect(response.body).to include review.content
      end
    end

    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされること' do
        get review_path review
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /reviews/new' do
    context 'ログイン済みのとき' do
      before do
        sign_in user
        get new_review_path
      end

      it '新規レビュー画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされること' do
        get new_review_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /reviews/edit' do
    context 'ログイン済みのとき' do
      before do
        sign_in user
        get edit_review_path review
      end

      it 'レビュー編集画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it 'フォームにレビュー情報が表示されること' do
        expect(response.body).to include review.title
        expect(response.body).to include review.content
      end
    end

    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされること' do
        get edit_review_path review
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '他ユーザのレビュー編集画面にアクセスするとき' do
      it 'トップページにリダイレクトされること' do
        sign_in user
        get edit_review_path other_review
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE /reviews' do
    context 'ログイン済みかつ自身のレビューを削除するとき' do
      before do
        sign_in user
        delete review_path review
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'レビューが削除されること' do
        expect(Review.find_by(id: review.id)).to be nil
      end
      it 'プロフィール画面にリダイレクトされること' do
        expect(response).to redirect_to user
      end
    end

    context 'ログイン済みかつ他者のレビューを削除するとき' do
      before do
        sign_in user
        delete review_path other_review
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it 'レビューが削除されないこと' do
        expect(Review.find_by(id: review.id)).not_to be nil
      end
      it 'トップページにリダイレクトされること' do
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていないとき' do
      it 'ログインページにリダイレクトされること' do
        get review_path review
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
