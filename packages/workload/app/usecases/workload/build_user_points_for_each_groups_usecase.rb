# frozen_string_literal: true

module Workload
  class BuildUserPointsForEachGroupsUsecase
    include UsecaseCallable

    def initialize(user_id:, date_range:, points: nil)
      @points = points
      @user_id = user_id
      @date_range = date_range
    end

    def call
      if @points.blank?
        @points = Workload::GetUserPointsUsecase.call(
          user_id: @user_id, date_range: @date_range
        )
      end

      user_account = User::Query::AccountQuery.get_account(@user_id)

      results = []
      workload_groups = Workload::GroupRepository.get_all
      (@date_range.begin.to_datetime..@date_range.end.to_datetime).each do |date|
        workload_groups.each do |group|
          point = @points.find { |point| point.date == date && point.workload_group_id == group.id }
          if point.nil?
            results << Workload::Point.new(
              user_account: user_account,
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
