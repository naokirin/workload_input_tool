# frozen_string_literal: true

module Workload
  class GetUserPointUsecase
    include UsecaseCallable

    def initialize(user_id:, date:, workload_group_id:)
      @user_id = user_id
      @date = date
      @workload_group_id = workload_group_id
    end

    def call
      Workload::PointRepository.get_user_point(
        @user_id, date: @date, workload_group_id: @workload_group_id
      )
    end
  end
end
