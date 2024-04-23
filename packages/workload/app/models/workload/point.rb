# frozen_string_literal: true

class Workload::Point < ApplicationRecord
  belongs_to :workload_group, class_name: 'Workload::Group'
  belongs_to :user_account, class_name: 'User::Account'

  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :date, presence: true
  validate :month_cannot_be_future

  private

  def month_cannot_be_future
    if date.present? && date.beginning_of_month.future?
      errors.add(:date, "は未来の月は指定できません")
    end
  end
end
