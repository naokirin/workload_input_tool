# frozen_string_literal: true

module Workload
  class PointsController < ApplicationController
    def index
      month = params[:month].presence
      current = Time.zone.now
      target_month = (current.beginning_of_month..current.end_of_month)
      if month.present?
        beginning_of_month = "#{month}-01".to_date
        if beginning_of_month.future?
          beginning_of_month = current
        end
        target_month = (beginning_of_month.beginning_of_month..beginning_of_month.end_of_month)
      end

      points = Workload::Point.where(
        user_account_id: current_user_account.id,
        date: target_month
      )

      build_form(points, target_month)

      Rails.logger.debug(@form.points)
    end

    def create
      points = permitted_updating_params[:points_attributes]&.values&.map do |params|
        point = Workload::Point.find_or_initialize_by(
          user_account_id: current_user_account.id,
          workload_group_id: params[:workload_group_id],
          date: params[:date]
        )
        point.value = params[:value]
        point
      end

      build_form(points, (points.first.date.beginning_of_month..points.first.date.end_of_month))

      if @form.points.all?(&:valid?)
        Workload::Point.transaction do
          @form.save!
        end
        redirect_to workload_points_path, notice: '工数を更新しました！'
      else
        flash[:alert] = '入力内容に誤りがあります'
        render :index
      end
    end

    private

    def build_form(points, target_month)
      @points = []
      workload_groups = Workload::Group.all
      (target_month.begin.to_datetime..target_month.end.to_datetime).each do |date|
        workload_groups.each do |group|
          point = points.find { |point| point.date == date && point.workload_group_id == group.id }
          if point.nil?
            @points << Workload::Point.new(
              user_account_id: current_user_account.id,
              date: date,
              workload_group_id: group.id
            )
          else
            @points << point
          end
        end
      end

      @form = Workload::Forms::Points::Form.new(@points)
    end

    def permitted_updating_params
      params.require(:workload_forms_points_form).permit(points_attributes: %i[workload_group_id date value])
    end
  end
end
