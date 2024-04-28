# frozen_string_literal: true

module Workload
  class Point
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer, default: nil
    attribute :user_account
    attribute :date, :date
    attribute :workload_group
    attribute :value, :integer

    def self.from_record(record)
      new(
        id: record.id,
        user_account: User::Query::GetAccountQuery.call(record.user_account_id),
        workload_group: record.workload_group,
        date: record.date,
        value: record.value
      )
    end

    delegate :id, to: :workload_group, prefix: true

    delegate :id, to: :user_account, prefix: true

    def workload_group_id=(id)
      self.workload_group = Workload::GroupRepository.find(id)
    end

    def user_account_id=(id)
      self.user_account = User::Query::GetAccountQuery.call(id)
    end

    def to_hash
      {
        id:,
        user_account_id: user_account.id,
        workload_group_id: workload_group.id,
        date:,
        value:
      }
    end

    def ==(other)
      other.is_a?(self.class) &&
        id == other.id &&
        user_account_id == other.user_account_id &&
        workload_group_id == other.workload_group_id &&
        date == other.date &&
        value == other.value
    end

    def hash
      [self.class, id, user_account_id, workload_group_id, date, value].hash
    end

    alias eql? ==
  end
end
