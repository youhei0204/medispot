require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe ':name' do
    context '30文字以内で値が存在するとき' do
      it 'オブジェクトが有効であること' do
        user.name = 'a' * 30
        expect(user).to be_valid
      end
    end

    context '30文字を超えるとき' do
      it 'オブジェクトが無効であること' do
        user.name = 'a' * 31
        expect(user).to be_invalid
        expect(user.errors.full_messages[0]).to eq('名前は30文字以内で入力してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが無効であること' do
        user.name = ''
        expect(user).to be_invalid
        expect(user.errors.full_messages[0]).to eq('名前を入力してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        user.name = ' '
        expect(user).to be_invalid
        expect(user.errors.full_messages[0]).to eq('名前を入力してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        user.name = nil
        expect(user).to be_invalid
        expect(user.errors.full_messages[0]).to eq('名前を入力してください')
      end
    end
  end

  describe ':introduction' do
    context '140文字以内で値が存在するとき' do
      it 'オブジェクトが有効であること' do
        user.introduction = 'a' * 140
        expect(user).to be_valid
      end
    end

    context '140文字を超えるとき' do
      it 'オブジェクトが無効であること' do
        user.introduction = 'a' * 141
        expect(user).to be_invalid
        expect(user.errors.full_messages[0]).to eq('自己紹介は140文字以内で入力してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが有効であること' do
        user.introduction = ''
        expect(user).to be_valid
      end
    end

    context '空白のとき' do
      it 'オブジェクトが有効であること' do
        user.introduction = ' '
        expect(user).to be_valid
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが有効であること' do
        user.introduction = nil
        expect(user).to be_valid
      end
    end
  end
end
