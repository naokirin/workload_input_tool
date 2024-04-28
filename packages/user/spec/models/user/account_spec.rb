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
      context 'weak password' do
        it 'is invalid' do
          record = build(:user_account_record, password: 'password')
          actual = record.valid?
          expect(actual).to be_falsey
          expect(record.errors[:password]).to include('は10文字以上で入力してください')
        end
      end
    end
  end
end
