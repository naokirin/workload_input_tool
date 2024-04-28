# frozen_string_literal: true

FactoryBot.define do
  factory :workload_group_record, class: Workload::GroupRecord do
    title { Faker::Lorem.sentence }
  end
end
