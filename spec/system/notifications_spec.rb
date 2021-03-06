# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notifications', type: :system, js: true do
  let(:user) { create(:user) }
  let(:reviewer) { create(:user) }
  let(:review) { create(:review, :spot, user_id: reviewer.id) }
  let(:review2) { create(:review, :spot, user_id: reviewer.id) }

  before do
    user.confirm
    reviewer.confirm
  end

  describe '通知ボックスの表示' do
    describe 'Aboutページの通知(通知種別:0)' do
      context 'ゲストユーザーでないとき' do
        before do
          visit root_path
          click_link '新規登録'
          fill_in 'user_name', with: 'user1'
          fill_in 'user_email', with: 'user1@email.com'
          fill_in 'user_password', with: 'testuser'
          fill_in 'user_password_confirmation', with: 'testuser'
          click_button '登録'
          User.find_by(email: 'user1@email.com').confirm
          sign_in_as(User.find_by(email: 'user1@email.com'))
          visit root_path
          find('#notification').click
        end

        context '初回ログインのとき' do
          it '通知ボックスにAboutページのリンクが表示されること' do
            within '.notification-box', match: :first do
              expect(page).to have_content "ようこそMediSpotへ！"
              expect(page).to have_content 'たった今'
              expect(page).to have_css '.notice'
            end
          end
          it 'ヘッダーの通知アイコンに新着通知用の赤マークが存在すること' do
            expect(page).to have_css '.new-badge'
          end
          it 'リンクをクリックするとAboutページが表示されること' do
            expect(page).not_to have_css '.about-page'
            click_link 'ようこそMediSpotへ！'
            expect(page).to have_css '.about-page'
            expect(page).to have_content '瞑想スポット検索Webサービス「MediSpot」'
          end
          it 'リンクをクリック後、新着通知用の赤マークが消えること' do
            click_link 'ようこそMediSpotへ！'
            expect(page).not_to have_css '.notice'
            expect(page).not_to have_css '.new-badge'
          end
        end

        context '2回目以降のログインのとき' do
          before do
            click_link 'ようこそMediSpotへ！'
            sleep 61
            logout
            sign_in_as(User.find_by(email: 'user1@email.com'))
            find('#notification').click
          end

          it '通知ボックスにAboutページのリンクが新たに表示されないこと' do
            within '.notification-inner' do
              links = all('a', text: 'ようこそMediSpotへ！')
              expect(links.count).to eq 1
              expect(page).not_to have_content 'たった今'
            end
          end
        end
      end

      context 'ゲストユーザーとしてログインしたとき' do
        before do
          sign_in_as_guest
          visit root_path
          find('#notification').click
        end

        it '通知ボックスにAboutページのリンクが表示されること' do
          within '.notification-box', match: :first do
            expect(page).to have_content "ようこそMediSpotへ！"
            expect(page).to have_content 'たった今'
            expect(page).to have_css '.notice'
          end
        end
        it 'ヘッダーの通知アイコンに新着通知用の赤マークが存在すること' do
          expect(page).to have_css '.new-badge'
        end
        it 'リンクをクリックするとAboutページが表示されること' do
          expect(page).not_to have_css '.about-page'
          click_link 'ようこそMediSpotへ！'
          expect(page).to have_css '.about-page'
          expect(page).to have_content '瞑想スポット検索Webサービス「MediSpot」'
        end
        it 'リンクをクリック後、新着通知用の赤マークが消えること' do
          click_link 'ようこそMediSpotへ！'
          expect(page).not_to have_css '.notice'
          expect(page).not_to have_css '.new-badge'
        end
      end
    end

    describe '新規ライクの通知(通知種別:1)' do
      context '自分以外のレビューをLIKEしたとき' do
        before do
          sign_in_as(user)
          visit review_path review
          find('.like-btn').click
          logout
          sign_in_as(reviewer)
          find('#notification').click
        end

        it '通知ボックスに新規のLIKE通知が表示されること' do
          within '.notification-inner' do
            expect(page).to have_content "#{user.name}さんが「#{review.title}」をLIKEしました。"
            expect(page).to have_content 'たった今'
            expect(page).to have_css '.notice'
          end
        end
        it 'ヘッダーの通知アイコンに新着通知用の赤マークが存在すること' do
          expect(page).to have_css '.new-badge'
        end
      end

      context '自分のレビューをLIKEしたとき' do
        before do
          sign_in_as(user)
          visit review_path review
          find('.like-btn').click
          find('#notification').click
        end

        it '通知ボックスに新規のLIKE通知が表示されないこと' do
          within '.notification-inner' do
            expect(page).to have_content "最新の通知はありません。"
          end
        end
      end

      context 'LIKEの新着通知をクリックしたとき' do
        before do
          create(:notification, user_id: reviewer.id, link_id: review.id,
                                sender_name: user.name, subject: 'first_notice')
          sleep 2
          create(:notification, user_id: reviewer.id, link_id: review2.id,
                                sender_name: user.name, subject: 'second_notice')
          sign_in_as(reviewer)
          find('#notification').click
          click_link('second_notice')
          sleep 3
          find('#notification').click
        end

        it 'LIKEされたレビューの詳細画面が表示されること' do
          expect(page).to have_current_path(review_path(review2))
        end

        it '通知ボックスから新着通知用の赤マークが消えること' do
          expect(page.all(".notification-box")[1]).
            to have_content "#{user.name}さんが「second_notice」をLIKEしました。"
          expect(page.all(".notification-box")[1]).to have_content 'たった今'
          expect(page.all(".notification-box")[1]).not_to have_css '.notice'
        end

        it '一度もクリックしていない通知がクリックした通知より上位に表示されること' do
          within '.notification-box', match: :first do
            expect(page).to have_content "#{user.name}さんが「first_notice」をLIKEしました。"
            expect(page).to have_content 'たった今'
            expect(page).to have_css '.notice'
          end
        end
      end
    end

    context '通知の総数が10件を超えるとき' do
      before do
        create_list(:review, 10, :spot, user_id: reviewer.id).each do |review|
          create(:notification, user_id: reviewer.id, link_id: review.id)
        end
        sleep 2
        sign_in_as(user)
        visit review_path review
        find('.like-btn').click
        logout
        sign_in_as(reviewer)
        visit review_path review
        find('#notification').click
      end

      it '通知ボックスに通知が10件のみ存在すること' do
        within '.notification-inner' do
          expect(page.all('.notification-box').count).to eq 10
        end
      end
      it '通知が作成日時の新しい順に存在すること' do
        within '.notification-box', match: :first do
          expect(page).to have_content "#{user.name}さんが「#{review.title}」をLIKEしました。"
          expect(page).to have_content 'たった今'
        end
      end
    end
  end
end
