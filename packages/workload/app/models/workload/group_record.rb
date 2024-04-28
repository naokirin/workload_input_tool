# frozen_string_literal: true

module Workload
  class GroupRecord < ApplicationRecord
    self.table_name = 'workload_groups'

    has_many :workload_points, class_name: 'Workload::PointRecord'

    validates :title, presence: true
  end
end
