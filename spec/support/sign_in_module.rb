# frozen_string_literal: true

module SignInModule
  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'testuser'
    click_button 'ログイン'
  end

  def sign_in_as_guest
    visit new_user_session_path
    click_link 'ゲストとしてログイン'
  end
end
