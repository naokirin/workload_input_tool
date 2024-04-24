# frozen_string_literal: true

module Workload
  module Forms
    module Points
      class Form < ::Forms::Base
        attr_accessor :points

        def initialize(workload_points)
          self.points = workload_points
        end

        def points_attributes=(attributes)
          self.points ||= attributes.map { |attrs| Workload::Point.new(attrs) }
        end
      end
    end
  end
end
