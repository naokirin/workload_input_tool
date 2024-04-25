# frozen_string_literal: true

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
  end
end
