# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let(:review) { create(:review, :spot, user_id: user.id) }

  before do
    user.confirm
    sign_in_as(user)
  end

  describe '最新レビューの表示' do
    before do
      create_list(:review, 5, :user, :spot)
      sleep 2
      create(
        :review, :user, spot_id: spot.id,
                        title: 'recent_title',
                        content: 'recent_content',
                        rate: 1.0
      )
      visit root_path
    end

    it '最新レビューが表示されること' do
      within '#review_1' do
        expect(page).to have_content 'recent_title'
        expect(page).to have_content 'recent_content'
        expect(page).to have_content spot.name
        expect(page).to have_content 1.0
      end
    end
    it '最新レビューが5件表示されること' do
      expect(all('.review-box').count).to eq 5
    end
  end

  describe '話題のスポットの表示' do
    before do
      create_list(:spot, 8).each do |spot|
        create(:review, :user, spot_id: spot.id, rate: 1.0)
      end
      create(:review, :user, spot_id: Spot.first.id, rate: 2.0)
      create(:review, :user, spot_id: Spot.second.id, rate: 3.0)
      create(:review, :user, spot_id: Spot.third.id, rate: 4.0)
      visit root_path
    end

    it '話題のスポットがスコア順に表示されること' do
      within '#spot_1' do
        expect(page).to have_content Spot.third.name
        expect(page).to have_content Spot.third.address
        expect(page).to have_content 2.5
      end
      within '#spot_2' do
        expect(page).to have_content Spot.second.name
        expect(page).to have_content Spot.second.address
        expect(page).to have_content 2.0
      end
      within '#spot_3' do
        expect(page).to have_content Spot.first.name
        expect(page).to have_content Spot.first.address
        expect(page).to have_content 1.5
      end
    end
    it '話題のスポットが8件表示されること' do
      expect(all('.spot-box').count).to eq 8
    end
  end
end
