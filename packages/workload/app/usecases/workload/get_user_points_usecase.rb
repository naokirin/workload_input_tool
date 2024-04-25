# frozen_string_literal: true

module Workload
  class GetUserPointsUsecase
    include UsecaseCallable

    def initialize(user_account:, date_range: nil)
      @user_account = user_account
      @date_range = date_range
    end

    def call
      Workload::PointRepository.get_user_points(
        @user_account.id, date_range: @date_range
      )
    end
  end
end
