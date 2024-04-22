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
          self.points ||= attributes.map { |attrs| Wokload::Point.new(attrs) }
        end

        def save!
          Workload::Point.transaction do
            self.points.each(&:save!)
          end
        end
      end
    end
  end
end
