# frozen_string_literal: true

module Workload
  class PointsController < ApplicationController
    before_action :authenticate_user_account!

    def index
      range = date_range
      points = Workload::BuildUserPointsForEachGroupsUsecase.call(
        group_repository: Workload::GroupRepository,
        user_account: current_user_account, date_range: range
      )

      @form = Workload::Forms::Points::Form.new(points)
      @date_range = (range.begin.to_datetime..range.end.to_datetime)
      @workload_groups = Workload::GroupRepository.get_all
    end

    def create
      attributes_list = permitted_updating_params[:points_attributes]&.values
      return redirect_to workload_points_path, alert: '入力内容に誤りがあります' if attributes_list.blank?

      first_date = attributes_list.first[:date].to_date
      @date_range = first_date.beginning_of_month..first_date.end_of_month
      @workload_groups = Workload::GroupRepository.get_all
      points = AssignOrBuildUserPointsUsecase.call(
        point_repository: Workload::PointRepository,
        group_repository: Workload::GroupRepository,
        user_account: current_user_account,
        date_range: @date_range,
        attributes_list: attributes_list
      )
      @form = Workload::Forms::Points::Form.new(points)

      saved = Workload::SaveUserPointsUsecase.call(
        point_repository: Workload::PointRepository,
        points: @form.points
      )
      if saved
        if @date_range.begin == Time.zone.now.beginning_of_month
          redirect_to workload_points_path, notice: '工数を更新しました！'
        else
          redirect_to workload_points_path(month: @date_range.begin.strftime('%Y-%m')), notice: '工数を更新しました！'
        end
      else
        flash[:alert] = '入力内容に誤りがあります'
        render :index
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

    def permitted_updating_params
      params.require(:workload_forms_points_form)
            .permit(points_attributes: %i[workload_group_id date value])
    end
  end
end
