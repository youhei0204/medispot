# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:review) { build(:review, :user, :spot) }
  let(:review_without_user) { build(:review, :spot) }
  let(:review_without_spot) { build(:review, :user) }

  describe 'モデルの関連付け' do
    context 'userとspotに紐づくとき' do
      it 'オブジェクトが有効であること' do
        expect(review).to be_valid
      end
    end

    context 'userに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        expect(review_without_user).to be_invalid
        expect(review_without_user.errors.full_messages[0]).to eq('Userを入力してください')
      end
    end

    context 'spotに紐づかないとき' do
      it 'オブジェクトが無効であること' do
        expect(review_without_spot).to be_invalid
        expect(review_without_spot.errors.full_messages[0]).to eq('Spotを入力してください')
      end
    end

    context '関連先のuserが削除されたとき' do
      it 'オブジェクトが削除されること' do
        review.save!
        expect do
          review.user.destroy
        end.to change { Review.count }.by(-1)
      end
    end

    context '関連先のspotが削除されたとき' do
      it 'オブジェクトが削除されること' do
        review.save!
        expect do
          review.spot.destroy
        end.to change { Review.count }.by(-1)
      end
    end
  end

  describe 'titleのバリデーション' do
    context '50文字以内で値が存在するとき' do
      it 'オブジェクトが有効であること' do
        review.title = 'a' * 50
        expect(review).to be_valid
      end
    end

    context '50文字を超えるとき' do
      it 'オブジェクトが無効であること' do
        review.title = 'a' * 51
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('タイトルは50文字以内で入力してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが無効であること' do
        review.title = ''
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('タイトルを入力してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        review.title = ' '
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('タイトルを入力してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        review.title = nil
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('タイトルを入力してください')
      end
    end
  end

  describe 'contentのバリデーション' do
    context '2000文字以内で値が存在するとき' do
      it 'オブジェクトが有効であること' do
        review.content = 'a' * 2000
        expect(review).to be_valid
      end
    end

    context '200文字を超えるとき' do
      it 'オブジェクトが無効であること' do
        review.content = 'a' * 2001
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('本文は2000文字以内で入力してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが無効であること' do
        review.content = ''
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('本文を入力してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        review.content = ' '
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('本文を入力してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        review.content = nil
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('本文を入力してください')
      end
    end
  end

  describe 'rateのバリデーション' do
    context '値が0以上で存在するとき' do
      it 'オブジェクトが有効であること' do
        review.rate = 0
        expect(review).to be_valid
      end
    end

    context '値が5.0以下で存在するとき' do
      it 'オブジェクトが有効であること' do
        review.rate = 5.0
        expect(review).to be_valid
      end
    end

    context '値が5.0を超えるとき' do
      it 'オブジェクトが無効であること' do
        review.rate = 5.1
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('星評価を選択してください')
      end
    end

    context '値がマイナスとき' do
      it 'オブジェクトが無効であること' do
        review.rate = -1
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('星評価を選択してください')
      end
    end

    context '値が文字列のとき' do
      it 'オブジェクトが無効であること' do
        review.rate = 'hello'
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('星評価を選択してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが無効であること' do
        review.rate = ''
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('星評価を選択してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        review.rate = ' '
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('星評価を選択してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        review.rate = nil
        expect(review).to be_invalid
        expect(review.errors.full_messages[0]).to eq('星評価を選択してください')
      end
    end
  end
end
