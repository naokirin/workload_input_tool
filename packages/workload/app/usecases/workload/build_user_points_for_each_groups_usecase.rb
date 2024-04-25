# frozen_string_literal: true

module Workload
  class BuildUserPointsForEachGroupsUsecase
    include UsecaseCallable

    def initialize(group_repository:,user_account:, date_range:, points: nil)
      @group_repository = group_repository
      @points = points
      @user_account = user_account
      @date_range = date_range
    end

    def call
      if @points.blank?
        @points = Workload::GetUserPointsUsecase.call(
          point_repository: Workload::PointRepository,
          user_account: @user_account, date_range: @date_range
        )
      end

      results = []
      workload_groups = @group_repository.get_all
      (@date_range.begin.to_datetime..@date_range.end.to_datetime).each do |date|
        workload_groups.each do |group|
          point = @points.find { |point| point.date == date && point.workload_group_id == group.id }
          if point.nil?
            results << Workload::Point.new(
              user_account: @user_account,
              date: date,
              workload_group: group
            )
          else
            results << point
          end
        end
      end

      results
    end
  end
end
