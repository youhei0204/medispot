require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let!(:review) { create(:review, user_id: user.id, spot_id: spot.id) }

  before do
    user.confirm
    sign_in user
  end

  describe 'POST /spots/favorites' do
    context 'スポットが保存済みでないとき' do
      it 'スポットが保存されること' do
        expect do
          post spot_favorites_path spot.id
        end.to change { Favorite.count }.by(1)
      end
    end

    context 'スポットが保存済みのとき' do
      before { user.favorites.create!(spot_id: spot.id) }

      it 'スポットが保存されないこと' do
        expect do
          post spot_favorites_path spot.id
        end.to change { Favorite.count }.by(0)
      end
    end
  end

  describe 'DELETE /spots/reviews' do
    context 'スポットが保存済みのとき' do
      before { user.favorites.create!(spot_id: spot.id) }

      it '保存が削除されること' do
        expect do
          delete spot_favorite_path spot, user
        end.to change { Favorite.count }.by(-1)
      end
    end

    context 'スポットが保存済みでないとき' do
      it 'リクエストが成功すること' do
        delete spot_favorite_path spot, user
        expect(response.status).to eq 204
      end
    end
  end
end
