# frozen_string_literal: true

require 'csv'

module Workload
  class GenerateCsvForPointAggregation
    include UsecaseCallable

    def initialize(date_range:, workload_groups:, points:)
      @date_range = date_range
      @workload_groups = workload_groups
      @points = points
    end

    def call
      CSV.generate do |csv|
        @points.each_with_index do |points, i|
          date_count = @date_range.count
          # user_account.name
          csv << account_name_row(points, date_count)

          # dates
          csv << date_row

          # group.title and points
          @workload_groups.each do |group|
            csv << group_title_and_points_row(group, points)
          end

          # blank line
          csv << blank_row(date_count) if i < @points.size - 1
        end
      end
    end

    private

    def account_name_row(points, date_count)
      [points[:user_account].name, *date_count.times.map { |_| nil }]
    end

    def date_row
      [nil, *@date_range.map { |date| date.strftime('%m/%d') }]
    end

    def group_title_and_points_row(group, points)
      ps = points[:points].select { |point| point.workload_group_id == group.id }.sort_by(&:date)
      [group.title, *ps.map(&:value)]
    end

    def blank_row(date_count)
      (date_count + 1).times.map { |_| nil }
    end
  end
end
