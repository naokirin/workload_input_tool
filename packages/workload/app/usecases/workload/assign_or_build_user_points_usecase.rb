# frozen_string_literal: true

module Workload
  class AssignOrBuildUserPointsUsecase
    include UsecaseCallable

    def initialize(user_id:, date_range:, attributes_list: nil)
      @user_id = user_id
      @date_range = date_range
      @attributes_list = attributes_list
    end

    def call
      points = @attributes_list&.map do |attributes|
        persisted_point = Workload::GetUserPointUsecase.call(
          user_id: @user_id,
          date: attributes[:date],
          workload_group_id: attributes[:workload_group_id]
        )
        Workload::Point.new(
          id: persisted_point&.id,
          user_account_id: @user_id,
          workload_group_id: attributes[:workload_group_id],
          date: attributes[:date],
          value: attributes[:value]
        )
      end

      Workload::BuildUserPointsForEachGroupsUsecase.call(
        points: points || [], user_id: @user_id, date_range: @date_range
      )
    end
  end
end
