# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workload::PointRecord, type: :model do
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:value).only_integer.is_greater_than_or_equal_to(0).allow_nil }
    it { is_expected.to validate_presence_of(:date) }
    describe 'validates date' do
      context 'is a future month' do
        it 'is invalid' do
          record = build(:workload_point_record, :with_new_group, date: Time.current.end_of_month + 1.day)
          actual = record.valid?
          expect(actual).to be_falsey
          expect(record.errors[:date]).to include('は未来の月は指定できません')
        end
      end

      context 'is not a future month' do
        it 'is valid' do
          record = build(:workload_point_record, :with_new_group, date: Time.current.end_of_month)
          actual = record.valid?
          expect(actual).to be_truthy
        end
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:workload_group).class_name('Workload::GroupRecord').with_foreign_key('workload_group_id') }
  end
end
