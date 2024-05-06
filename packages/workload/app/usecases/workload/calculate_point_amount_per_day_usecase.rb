# frozen_string_literal: true

module Workload
  class CalculatePointAmountPerDayUsecase
    include UsecaseCallable

    def initialize(date_range:, points:)
      @date_range = date_range
      @points = points
    end

    def call
      (@date_range.begin.to_datetime..@date_range.end.to_datetime).map do |date|
        points_per_day = @points.select { |point| point.date == date }
        total_point = points_per_day.map(&:value).compact.sum
        next { validation: false, amount: total_point } if total_point != 100 && date <= Time.zone.today

        { validation: true, amount: total_point }
      end
    end
  end
end
