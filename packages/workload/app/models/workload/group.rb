# frozen_string_literal: true

class Workload::Group < ApplicationRecord
  has_many :workload_points

  validates :title, presence: true
end
