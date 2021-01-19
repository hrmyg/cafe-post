require 'rails_helper'

RSpec.describe '新規登録', type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録がうまくいくこと' do
    it '全ての情報が存在していれば登録できる' do
      expect(@user).to be_valid
    end
    it 'introductionがなく、それ以外が存在していれば登録できる' do
      @user.introduction = ''
      expect(@user).to be_valid
    end
  end

  context 'ユーザー新規登録がうまくいかないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'nicknameが51文字以上の場合登録できない' do
      @user.nickname = ('a' * 51)
      @user.valid?
      expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 50 characters)')
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank", 'Email is invalid')
    end
    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailに@がない場合登録できない' do
      @user.email = 'aaaa.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid', 'Email is invalid')
    end
    it 'emailは.小文字(.comなど)がない場合登録できない' do
      @user.email = 'Aaaa@gmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", 'Password is invalid')
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = 'yh111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが数字だけでは登録できない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'passwordが存在していてもpassword_confirmationが空では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
