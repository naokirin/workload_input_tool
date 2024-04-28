# frozen_string_literal: true

module Workload
  module GroupRepository
    def get_all
      Workload::GroupRecord.all.map do |record|
        Workload::Group.from_record(record)
      end
    end

    def get_group(id)
      Workload::GroupRecord.find_by(id: id)&.then do |record|
        Workload::Group.from_record(record)
      end
    end

    module_function :get_all, :get_group
  end
end
