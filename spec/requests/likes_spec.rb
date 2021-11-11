require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let!(:review) { create(:review, :spot, user_id: user.id) }

  before do
    user.confirm
    sign_in user
  end

  describe 'POST /reviews/likes' do
    context 'レビューをライク済みでないとき' do
      it 'レビューがライクされること' do
        expect do
          post review_likes_path review.id
        end.to change { Like.count }.by(1)
      end
    end

    context 'レビューがライク済みのとき' do
      before { user.likes.create!(review_id: review.id) }

      it 'レビューがライクされないこと' do
        expect do
          post review_likes_path review.id
        end.to change { Like.count }.by(0)
      end
    end
  end

  describe 'DELETE /reviews/reviews' do
    context 'レビューがライク済みのとき' do
      before { user.likes.create!(review_id: review.id) }

      it 'ライクが削除されること' do
        expect do
          delete review_like_path review, user
        end.to change { Like.count }.by(-1)
      end
    end

    context 'レビューがライク済みでないとき' do
      it 'リクエストが成功すること' do
        delete review_like_path review, user
        expect(response.status).to eq 204
      end
    end
  end
end
