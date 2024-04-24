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
      self.new(
        id: record.id,
        user_account: User::Query::AccountQuery.get_account(record.user_account_id),
        workload_group: record.workload_group,
        date: record.date,
        value: record.value
      )
    end

    def workload_group_id
      workload_group.id
    end

    def user_account_id
      user_account.id
    end

    def workload_group_id=(id)
      self.workload_group = Workload::GroupRepository.get_group(id)
    end

    def user_account_id=(id)
      self.user_account = User::Query::AccountQuery.get_account(id)
    end

    def to_hash
      {
        id: id,
        user_account_id: user_account.id,
        workload_group_id: workload_group.id,
        date: date,
        value: value
      }
    end
  end
end
