# frozen_string_literal: true

module Workload
  class PointRecord < ApplicationRecord
    self.table_name = 'workload_points'

    belongs_to :workload_group, class_name: 'Workload::GroupRecord'

    validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
    validates :date, presence: true
    validate :month_cannot_be_future

    private

    def month_cannot_be_future
      return unless date.present? && date.beginning_of_month.future?

      errors.add(:date, 'は未来の月は指定できません')
    end
  end
end
