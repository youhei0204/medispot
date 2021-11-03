# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :request do
  describe 'GET /home' do
    it 'ホーム画面の表示に成功すること' do
      get home_pages_home_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET root' do
    it 'ルートパスからホーム画面の表示に成功すること' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
