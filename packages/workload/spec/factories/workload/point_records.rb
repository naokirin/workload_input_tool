# frozen_string_literal: true

FactoryBot.define do
  factory :workload_point_record, class: 'Workload::PointRecord' do
    date { '2021-08-01' }
    value { 1 }
    workload_group { association :workload_group_record }
  end
end
