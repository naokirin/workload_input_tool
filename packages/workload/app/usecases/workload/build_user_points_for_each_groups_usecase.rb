# frozen_string_literal: true

module Workload
  class BuildUserPointsForEachGroupsUsecase
    include UsecaseCallable

    def initialize(group_repository:, user_account:, date_range:, points: nil)
      @group_repository = group_repository
      @points = points
      @user_account = user_account
      @date_range = date_range
    end

    def call
      @points = build_points_no_exist if @points.blank?

      results = []
      workload_groups = @group_repository.all
      (@date_range.begin.to_datetime..@date_range.end.to_datetime).each do |date|
        workload_groups.each do |group|
          results << build_point(points: @points, user_account: @user_account, date:, group:)
        end
      end

      results
    end

    private

    def build_points_no_exist
      Workload::GetUserPointsUsecase.call(
        point_repository: Workload::PointRepository,
        user_account: @user_account, date_range: @date_range
      )
    end

    def build_point(points:, user_account:, date:, group:)
      found_point = points.find { |point| point.date == date && point.workload_group_id == group.id }
      if found_point.nil?
        Workload::Point.new(
          user_account:,
          date:,
          workload_group: group
        )
      else
        found_point
      end
    end
  end
end
