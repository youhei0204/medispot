# frozen_string_literal: true

module LogoutModule
  def logout
    find('#icon').click
    click_link 'ログアウト'
  end
end
