require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:notification) { create(:notification, user: user) }
  let(:notification_params) { attributes_for(:notification) }

  describe 'モデルの関連付け' do
    context 'userに紐づくとき' do
      it 'オブジェクトが有効であること' do
        notification = user.notifications.build(notification_params)
        expect(notification).to be_valid
      end
    end

    context 'userに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        notification = Notification.new(notification_params)
        expect(notification).to be_invalid
        expect(notification.errors.full_messages[0]).to eq('Userを入力してください')
      end
    end

    context '関連先のuserが削除されたとき' do
      it 'オブジェクトが削除されること' do
        notification = user.notifications.create!(notification_params)
        expect do
          notification.user.destroy
        end.to change { Notification.count }.by(-1)
      end
    end
  end

  describe 'request_typeのバリデーション' do
    context '空のとき' do
      it 'オブジェクトが無効であること' do
        notification.request_type = ''
        expect(notification).to be_invalid
        expect(notification.errors.full_messages[0]).to eq('Request typeは数値で入力してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        notification.request_type = ' '
        expect(notification).to be_invalid
        expect(notification.errors.full_messages[0]).to eq('Request typeは数値で入力してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        notification.request_type = nil
        expect(notification).to be_invalid
        expect(notification.errors.full_messages[0]).to eq('Request typeは数値で入力してください')
      end
    end
  end

  describe 'new_flagのバリデーション' do
    context 'trueのとき' do
      it 'オブジェクトが有効であること' do
        notification.new_flag = true
        expect(notification).to be_valid
      end
    end

    context 'falseのとき' do
      it 'オブジェクトが有効であること' do
        notification.new_flag = false
        expect(notification).to be_valid
      end
    end

    context 'true, false以外のとき' do
      it 'オブジェクトが無効であること' do
        notification.new_flag = ''
        expect(notification).to be_invalid
        expect(notification.errors.full_messages[0]).to eq('New flagは一覧にありません')
      end
    end
  end
end
