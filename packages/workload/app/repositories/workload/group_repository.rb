# frozen_string_literal: true

module Workload
  module GroupRepository
    extend self

    def all
      Workload::GroupRecord.all.map do |record|
        Workload::Group.from_record(record)
      end
    end

    def find(id)
      Workload::GroupRecord.find_by(id:)&.then do |record|
        Workload::Group.from_record(record)
      end
    end
  end
end
