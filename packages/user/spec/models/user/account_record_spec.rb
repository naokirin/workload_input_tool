# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::AccountRecord, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(10).is_at_most(128) }

    describe 'validates password' do
      context 'when password is weak' do
        it 'is invalid' do
          record = build(:user_account_record, password: 'abcdefghijklmn')
          actual = record.valid?
          expect(actual).to be_falsey
          expect(record.errors[:password]).to include('パスワードは半角英数字をそれぞれ1文字以上含む推測されにくい8文字以上で設定してください')
        end
      end
    end
  end
end
