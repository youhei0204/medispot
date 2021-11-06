require 'rails_helper'

RSpec.describe 'Spot', type: :request do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }

  before do
    user.confirm
    sign_in user
  end

  describe 'GET /spots' do
    before{ get spot_path spot }

    it 'スポット詳細画面の表示に成功すること' do
      expect(response).to have_http_status(:success)
    end
    it 'スポット情報が表示されること' do
      expect(response.body).to include spot.name
      expect(response.body).to include spot.address
    end
  end
end
