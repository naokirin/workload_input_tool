# frozen_string_literal: true

class Workload::Point < ApplicationRecord
  belongs_to :workload_group, class_name: 'Workload::Group'
  belongs_to :user_account, class_name: 'User::Account'

  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
end
