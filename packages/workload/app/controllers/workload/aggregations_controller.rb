# frozen_string_literal: true

require 'csv'

module Workload
  class AggregationsController < ApplicationController
    before_action :authenticate_user_account!

    def index
      range = date_range
      user_accounts = User::Query::GetAllAccountsQuery.call
      @points = user_accounts.map do |user_account|
        {
          user_account: user_account,
          points: Workload::BuildUserPointsForEachGroupsUsecase.call(
            group_repository: Workload::GroupRepository,
            user_account: user_account, date_range: range
          )
        }
      end
      @date_range = (range.begin.to_datetime..range.end.to_datetime)
      @workload_groups = Workload::GroupRepository.get_all

      respond_to do |format|
        format.html
        format.csv do
          send_data csv_data, filename: "工数入力#{@date_range.begin.strftime('%Y-%m')}.csv"
        end
      end
    end

    private

    def date_range
      month = params[:month].presence
      current = Time.zone.now
      range = (current.beginning_of_month..current.end_of_month)
      if month.present?
        beginning_of_month = "#{month}-01".to_date
        beginning_of_month = current if beginning_of_month.future?
        range = beginning_of_month.beginning_of_month..beginning_of_month.end_of_month
      end

      range
    end

    def csv_data
      CSV.generate do |csv|
        @points.each_with_index do |points, i|
          date_count = @date_range.count
          # user_account.name
          csv << [
            points[:user_account].name,
            *date_count.times.map { |_| nil }
          ]

          # dates
          csv << [
            nil,
            *@date_range.map { |date| date.strftime('%m/%d') }
          ]

          # group.title and points
          @workload_groups.each do |group|
            ps = points[:points].select { |point| point.workload_group_id == group.id }.sort_by(&:date)
            csv << [group.title ,*ps.map { |point| point.value }]
          end

          # blank line
          if i < @points.size - 1
            csv << (date_count + 1).times.map { |_| nil }
          end
        end
      end
    end
  end
end
