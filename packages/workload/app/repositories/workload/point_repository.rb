# frozen_string_literal: true

module Workload
  module PointRepository
    def get_user_points(user_account_id, date_range: nil)
      user = User::Query::GetAccountQuery.call(user_account_id)
      return nil if user.nil?

      conditions = { user_account_id: user_account_id }
                     .merge(date_range.present? ? { date: date_range } : {})
      point_records = Workload::PointRecord.where(conditions)
      point_records.map do |point_record|
        Workload::Point.from_record(point_record)
      end
    end

    def get_user_point(user_account_id, date:, workload_group_id:)
      user = User::Query::GetAccountQuery.call(user_account_id)
      return nil if user.nil?

      point_record = Workload::PointRecord.find_by(
        user_account_id: user_account_id,
        date: date,
        workload_group_id: workload_group_id
      )
      return nil if point_record.nil?

      Workload::Point.from_record(point_record)
    end

    def save_points!(points)
      Workload::PointRecord.transaction do
        points.each do |point|
          record = Workload::PointRecord.find_or_initialize_by(id: point.id)
          record.assign_attributes(point.to_hash)
          record.save!
        end
      end
    end

    module_function :get_user_points, :get_user_point, :save_points!
  end
end
