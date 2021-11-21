require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }
  let(:reviewer) { create(:user) }
  let(:review) { create(:review, :spot, user_id: reviewer.id) }
  let!(:notification) { create(:notification, :user, link_id: review.id) }

  describe 'GET /show' do
    before do
      user.confirm
      sign_in user
    end

    context 'LIKEの通知かつ対象のレビューが存在するとき' do
      before { get user_notification_path reviewer.id, Notification.last.id }

      it 'リクエストに成功すること' do
        expect(response.status).to eq 302
      end
      it 'レビュー詳細画面にリダイレクトされること' do
        expect(response).to redirect_to review_path review
      end
    end

    context 'LIKEの通知かつ対象のレビューが削除済のとき' do
      before do
        review.destroy
        get user_notification_path reviewer.id, Notification.last.id
      end

      it 'リクエストに成功すること' do
        expect(response.status).to eq 302
      end
      it 'プロフィール画面にリダイレクトされること' do
        expect(response).to redirect_to user_path user
      end
    end
  end
end
