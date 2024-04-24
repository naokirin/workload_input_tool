# frozen_string_literal: true

module Workload
  module GroupRepository
    def get_all
      Workload::GroupRecord.all.map do |group|
        Workload::Group.from_record(group)
      end
    end

    def get_group(id)
      Workload::Group.from_record(Workload::GroupRecord.find_by(id: id))
    end

    module_function :get_all, :get_group
  end
end
