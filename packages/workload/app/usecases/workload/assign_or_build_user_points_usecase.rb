# frozen_string_literal: true

module Workload
  class AssignOrBuildUserPointsUsecase
    include UsecaseCallable

    def initialize(user_account:, date_range:, attributes_list: nil)
      @user_account = user_account
      @date_range = date_range
      @attributes_list = attributes_list
    end

    def call
      points = @attributes_list&.map do |attributes|
        persisted_point = Workload::GetUserPointUsecase.call(
          user_account: @user_account,
          date: attributes[:date],
          workload_group_id: attributes[:workload_group_id]
        )
        Workload::Point.new(
          id: persisted_point&.id,
          user_account: @user_account,
          workload_group_id: attributes[:workload_group_id],
          date: attributes[:date],
          value: attributes[:value]
        )
      end

      Workload::BuildUserPointsForEachGroupsUsecase.call(
        points: points || [], user_account: @user_account, date_range: @date_range
      )
    end
  end
end
