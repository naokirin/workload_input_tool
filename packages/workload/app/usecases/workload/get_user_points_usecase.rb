# frozen_string_literal: true

module Workload
  class GetUserPointsUsecase
    include UsecaseCallable

    def initialize(user_id:, date_range: nil)
      @user_id = user_id
      @date_range = date_range
    end

    def call
      Workload::PointRepository.get_user_points(
        @user_id, date_range: @date_range
      )
    end
  end
end
