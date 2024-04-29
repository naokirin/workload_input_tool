# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workload::AssignOrBuildUserPointsUsecase do
  describe '#call' do
    subject(:result) do
      described_class.call(
        point_repository: Workload::PointRepository, group_repository: Workload::GroupRepository,
        user_account: user_account, date_range: date_range, attributes_list: attributes_list
      )
    end

    let!(:user_account) { User::Query::Account.from_record(create(:user_account_record)) }
    let!(:date_range) { Time.zone.parse('2024-01-01')..Time.zone.parse('2024-01-03') }
    let!(:group) { Workload::Group.from_record(create(:workload_group_record)) }

    context 'when user has no persisted points' do
      context 'when does not exist attributes' do
        let(:attributes_list) { [] }

        it 'builds empty user points' do
          expect(result).to all(be_a(Workload::Point))
          expect(result).to(
            contain_exactly(
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-01'), value: nil),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-02'), value: nil),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-03'), value: nil),
            )
          )
        end
      end

      context 'when exist attributes' do
        let(:attributes_list) do
          [
            { user_account_id: user_account.id, workload_group_id: group.id, date: Time.zone.parse('2024-01-01'), value: 1 },
            { user_account_id: user_account.id, workload_group_id: group.id, date: Time.zone.parse('2024-01-02'), value: 2 },
            { user_account_id: user_account.id, workload_group_id: group.id, date: Time.zone.parse('2024-01-03'), value: 3 },
          ]
        end

        it 'builds user points with attributes' do
          expect(result).to all(be_a(Workload::Point))
          expect(result).to(
            contain_exactly(
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-01'), value: 1),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-02'), value: 2),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-03'), value: 3),
            )
          )
        end
      end
    end

    context 'when user has persisted points' do
      let!(:workload_point) do
        Workload::Point.from_record(
          create(:workload_point_record,
                 user_account_id: user_account.id, workload_group_id: group.id,
                 date: Time.zone.parse('2024-01-01'), value: 1)
        )
      end

      context 'when user has no attributes' do
        let(:attributes_list) { [] }

        it 'builds empty user points' do
          expect(result).to all(be_a(Workload::Point))
          expect(result).to(
            contain_exactly(
              Workload::Point.new(id: workload_point.id, user_account:, workload_group: group, date: Time.zone.parse('2024-01-01'), value: 1),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-02'), value: nil),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-03'), value: nil),
              )
          )
        end
      end

      context 'when user has points' do
        let(:attributes_list) do
          [
            { user_account_id: user_account.id, workload_group_id: group.id, date: Time.zone.parse('2024-01-01'), value: 10 },
            { user_account_id: user_account.id, workload_group_id: group.id, date: Time.zone.parse('2024-01-02'), value: 2 },
            { user_account_id: user_account.id, workload_group_id: group.id, date: Time.zone.parse('2024-01-03'), value: 3 },
          ]
        end

        it 'builds user points with attributes' do
          expect(result).to all(be_a(Workload::Point))
          expect(result).to(
            contain_exactly(
              Workload::Point.new(id: workload_point.id, user_account:, workload_group: group, date: Time.zone.parse('2024-01-01'), value: 10),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-02'), value: 2),
              Workload::Point.new(id: nil, user_account:, workload_group: group, date: Time.zone.parse('2024-01-03'), value: 3),
              )
          )
        end
      end
    end
  end
end
