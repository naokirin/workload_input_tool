# frozen_string_literal: true

module Workload
  class AssignOrBuildUserPointsUsecase
    include UsecaseCallable

    def initialize(point_repository:, group_repository:, user_account:, date_range:, attributes_list: nil)
      @point_repository = point_repository
      @group_repository = group_repository
      @user_account = user_account
      @date_range = date_range
      @attributes_list = attributes_list
    end

    def call
      points = @attributes_list&.map do |attributes|
        persisted_point = Workload::GetUserPointUsecase.call(
          point_repository: @point_repository,
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
        group_repository: @group_repository,
        points: points || [], user_account: @user_account, date_range: @date_range
      )
    end
  end
end
