# frozen_string_literal: true

module Workload
  class GetUserPointUsecase
    include UsecaseCallable

    def initialize(user_account:, date:, workload_group_id:)
      @user_account = user_account
      @date = date
      @workload_group_id = workload_group_id
    end

    def call
      Workload::PointRepository.get_user_point(
        @user_account.id, date: @date, workload_group_id: @workload_group_id
      )
    end
  end
end
