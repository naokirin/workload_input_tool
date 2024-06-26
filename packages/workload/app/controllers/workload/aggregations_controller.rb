# frozen_string_literal: true

module Workload
  class AggregationsController < User::ApplicationController
    before_action :authenticate_user_account!

    def index
      range = date_range
      @teams = User::Query::GetAllTeamsQuery.call
      @team = @teams.find { |team| team.id == params[:team].to_i }
      @points = points(range, team: @team)
      @date_range = (range.begin.to_datetime..range.end.to_datetime)
      @workload_groups = Workload::GroupRepository.all

      respond_to do |format|
        format.html
        format.csv do
          send_data csv_data, filename: "工数入力#{@date_range.begin.strftime('%Y-%m')}.csv"
        end
      end
    end

    private

    def points(date_range, team:)
      all_user_accounts = User::Query::GetAllAccountsQuery.call
      user_accounts = if team.present?
                        all_user_accounts.select do |user_account|
                          user_account.teams.any? { |user_team| user_team.id == team&.id }
                        end
                      else
                        all_user_accounts
                      end
      user_accounts.map do |user_account|
        points = Workload::BuildUserPointsForEachGroupsUsecase.call(
          group_repository: Workload::GroupRepository,
          user_account:, date_range:
        )
        {
          user_account:, points:,
          amounts: Workload::CalculatePointAmountPerDayUsecase.call(date_range:, points:)
        }
      end
    end

    def date_range
      month = params[:month].presence
      current = Time.zone.now
      range = current.all_month
      if month.present?
        beginning_of_month = "#{month}-01".to_date
        beginning_of_month = current if beginning_of_month.future?
        range = beginning_of_month.all_month
      end

      range
    end

    def csv_data
      Workload::GenerateCsvForPointAggregation.call(
        date_range: @date_range, workload_groups: @workload_groups, points: @points
      )
    end
  end
end
