require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }

  describe 'モデルの関連付け' do
    context 'userとspotに紐づくとき' do
      it 'オブジェクトが有効であること' do
        favorite = Favorite.new(user_id: user.id, spot_id: spot.id)
        expect(favorite).to be_valid
      end
    end

    context 'userに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        favorite = Favorite.new(spot_id: spot.id)
        expect(favorite).to be_invalid
        expect(favorite.errors.full_messages[0]).to eq('Userを入力してください')
      end
    end

    context 'spotに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        favorite = Favorite.new(user_id: user.id)
        expect(favorite).to be_invalid
        expect(favorite.errors.full_messages[0]).to eq('Spotを入力してください')
      end
    end

    context '関連先のuserが削除されたとき' do
      it 'オブジェクトが削除されること' do
        favorite = Favorite.create!(user_id: user.id, spot_id: spot.id)
        expect do
          favorite.user.destroy
        end.to change { Favorite.count }.by(-1)
      end
    end

    context '関連先のspotが削除されたとき' do
      it 'オブジェクトが削除されること' do
        favorite = Favorite.create!(user_id: user.id, spot_id: spot.id)
        expect do
          favorite.spot.destroy
        end.to change { Favorite.count }.by(-1)
      end
    end
  end

  describe 'バリデーション' do
    context 'user_idとspot_idの組み合わせが既に存在するとき' do
      before do
        Favorite.create!(user_id: user.id, spot_id: spot.id)
      end

      it 'オブジェクトが無効であること' do
        favorite = Favorite.new(user_id: user.id, spot_id: spot.id)
        expect(favorite).to be_invalid
        expect(favorite.errors.full_messages[0]).to eq('Spotはすでに存在します')
      end
    end
  end
end
