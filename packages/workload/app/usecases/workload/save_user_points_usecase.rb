# frozen_string_literal: true

module Workload
  class SaveUserPointsUsecase
    include UsecaseCallable

    def initialize(points:)
      @points = points
    end

    def call
      return false unless @points.all?(&:valid?)

      Workload::PointRepository.save_points!(@points)
    end
  end
end
