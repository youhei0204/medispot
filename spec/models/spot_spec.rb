# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:spot) { build(:spot) }

  describe ':name' do
    context '100文字以内で値が存在するとき' do
      it 'オブジェクトが有効であること' do
        spot.name = 'a' * 100
        expect(spot).to be_valid
      end
    end

    context '100文字を超えるとき' do
      it 'オブジェクトが無効であること' do
        spot.name = 'a' * 101
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('名前は100文字以内で入力してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが無効であること' do
        spot.name = ''
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('名前を入力してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        spot.name = ' '
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('名前を入力してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        spot.name = nil
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('名前を入力してください')
      end
    end
  end

  describe ':address' do
    context '200文字以内で値が存在するとき' do
      it 'オブジェクトが有効であること' do
        spot.address = 'a' * 200
        expect(spot).to be_valid
      end
    end

    context '200文字を超えるとき' do
      it 'オブジェクトが無効であること' do
        spot.address = 'a' * 201
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('住所は200文字以内で入力してください')
      end
    end

    context '空のとき' do
      it 'オブジェクトが無効であること' do
        spot.address = ''
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('住所を入力してください')
      end
    end

    context '空白のとき' do
      it 'オブジェクトが無効であること' do
        spot.address = ' '
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('住所を入力してください')
      end
    end

    context 'nilのとき' do
      it 'オブジェクトが無効であること' do
        spot.address = nil
        expect(spot).to be_invalid
        expect(spot.errors.full_messages[0]).to eq('住所を入力してください')
      end
    end
  end
end
