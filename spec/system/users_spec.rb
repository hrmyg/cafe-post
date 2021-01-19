require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      visit root_path
      expect(page).to have_content('Sign Up')
      visit new_user_registration_path
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'introduction', with: @user.introduction
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('Sign Up')
      expect(page).to have_no_content('Log In')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit root_path
      expect(page).to have_content('Sign Up')
      visit new_user_registration_path
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'introduction', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      visit root_path
      expect(page).to have_content('Log In')
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      expect(page).to have_no_content('Sign Up')
      expect(page).to have_no_content('Log In')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      visit root_path
      expect(page).to have_content('Log In')
      visit new_user_session_path
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq new_user_session_path
    end
  end
end
