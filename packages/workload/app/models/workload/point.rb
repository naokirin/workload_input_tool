# frozen_string_literal: true

class Workload::Point < ApplicationRecord
  belongs_to :workload_group, class_name: 'Workload::Group'
  belongs_to :user_account, class_name: 'User::Account'

  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :date, presence: true
  validate :date_cannot_be_future

  private

  def date_cannot_be_future
    if date.present? && date.beginning_of_month.future?
      errors.add(:date, "は未来の日付は指定できません")
    end
  end
end
