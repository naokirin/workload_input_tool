# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workload::GroupRepository, type: :repository do
  describe '.all' do
    context 'when exists no group' do
      it 'returns an empty array' do
        expect(described_class.all).to eq([])
      end
    end

    context 'when exists groups' do
      it 'returns all groups' do
        groups = create_list(:workload_group_record, 3)
        expected = groups.map { |group| Workload::Group.from_record(group) }
        expect(described_class.all).to match_array(expected)
      end
    end
  end

  describe '.find' do
    context 'when group does not exist' do
      it 'returns nil' do
        expect(described_class.find(1)).to be_nil
      end
    end

    context 'when group exists' do
      it 'returns a group' do
        group = create(:workload_group_record)
        expect(described_class.find(group.id)).to eq(Workload::Group.from_record(group))
      end
    end
  end
end
