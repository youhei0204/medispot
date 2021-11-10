require 'rails_helper'

RSpec.describe 'Spot', type: :request do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let!(:review) { create(:review, :user, spot_id: spot.id) }

  before do
    user.confirm
    sign_in user
  end

  describe 'GET /spots:id' do
    before { get spot_path spot }

    it 'スポット詳細画面の表示に成功すること' do
      expect(response).to have_http_status(:success)
    end
    it 'スポット情報とレビュー情報が表示されること' do
      expect(response.body).to include spot.name
      expect(response.body).to include spot.address
      expect(response.body).to include review.title
    end
  end

  describe 'GET /spots' do
    before do
      create_list(:spot, 5, :tokyo).each do |spot|
        create(:review, :user, spot_id: spot.id, title: 'テストタイトル')
      end
      Spot.last.update!(address: "京都")
    end

    context 'エリアのみで検索し、検索結果が存在するとき' do
      before { get spots_path, params: { area: "東京", keyword: "" } }

      it 'スポット一覧画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it '検索結果のスポット一覧が表示されること' do
        expect(response.body).to include "東京都"
        expect(response.body).to include "検索結果：4件"
      end
    end

    context 'キーワードのみで検索し、検索結果が存在するとき' do
      before { get spots_path, params: { area: "", keyword: "トーキョー" } }

      it 'スポット一覧画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it '検索結果のスポット一覧が表示されること' do
        expect(response.body).to include "東京都"
        expect(response.body).to include "検索結果：5件"
      end
    end

    context 'エリア・キーワード両方で検索し、検索結果が存在するとき' do
      before { get spots_path, params: { area: "東京", keyword: "テストタイトル" } }

      it 'スポット一覧画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it '検索結果のスポット一覧が表示されること' do
        expect(response.body).to include "東京都"
        expect(response.body).to include "検索結果：4件"
      end
    end

    context '検索条件が空のとき' do
      before do
        get spots_path, params: { area: "", keyword: "" },
                        headers: { "HTTP_REFERER": "http://example.com/home" }
      end

      it '遷移元画面の表示に成功すること' do
        expect(response.status).to eq 302
        expect(response).to redirect_to('http://example.com/home')
      end
    end

    context '検索結果が0件のとき' do
      before { get spots_path, params: { area: "ニューヨーク", keyword: "" } }

      it 'スポット一覧画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it '検索結果のスポット一覧が表示されないこと' do
        expect(response.body).not_to include "東京"
        expect(response.body).to include "検索結果：0件"
      end
    end

    context '検索結果が100件を超えるとき' do
      before do
        create_list(:spot, 101, address: "ニューヨーク").each do |spot|
          create(:review, :user, spot_id: spot.id)
        end
        get spots_path, params: { area: "ニューヨーク", keyword: "" }
      end

      it 'スポット一覧画面の表示に成功すること' do
        expect(response).to have_http_status(:success)
      end
      it '検索結果のスポット一覧が100件まで表示されること' do
        expect(response.body).to include "ニューヨーク"
        expect(response.body).to include "検索結果：100件"
      end
    end
  end
end
