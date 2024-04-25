# frozen_string_literal: true

module Workload
  class SaveUserPointsUsecase
    include UsecaseCallable

    def initialize(point_repository:, points:)
      @point_repository = point_repository
      @points = points
    end

    def call
      return false unless @points.all?(&:valid?)

      @point_repository.save_points!(@points)
    end
  end
end
