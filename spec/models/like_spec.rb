require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let!(:review) { create(:review, :spot, user_id: user.id) }

  describe 'モデルの関連付け' do
    context 'userとreviewに紐づくとき' do
      it 'オブジェクトが有効であること' do
        like = Like.new(user_id: user.id, review_id: review.id)
        expect(like).to be_valid
      end
    end

    context 'userに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        like = Like.new(review_id: review.id)
        expect(like).to be_invalid
        expect(like.errors.full_messages[0]).to eq('Userを入力してください')
      end
    end

    context 'reviewに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        like = Like.new(user_id: user.id)
        expect(like).to be_invalid
        expect(like.errors.full_messages[0]).to eq('Reviewを入力してください')
      end
    end

    context '関連先のuserが削除されたとき' do
      it 'オブジェクトが削除されること' do
        like = Like.create!(user_id: user.id, review_id: review.id)
        expect do
          like.user.destroy
        end.to change { Like.count }.by(-1)
      end
    end

    context '関連先のreviewが削除されたとき' do
      it 'オブジェクトが削除されること' do
        like = Like.create!(user_id: user.id, review_id: review.id)
        expect do
          like.review.destroy
        end.to change { Like.count }.by(-1)
      end
    end
  end

  describe 'バリデーション' do
    context 'user_idとreview_idの組み合わせが既に存在するとき' do
      before do
        Like.create!(user_id: user.id, review_id: review.id)
      end

      it 'オブジェクトが無効であること' do
        like = Like.new(user_id: user.id, review_id: review.id)
        expect(like).to be_invalid
        expect(like.errors.full_messages[0]).to eq('Reviewはすでに存在します')
      end
    end
  end
end
