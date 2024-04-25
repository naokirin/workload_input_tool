# frozen_string_literal: true

module Workload
  class GetUserPointsUsecase
    include UsecaseCallable

    def initialize(point_repository:, user_account:, date_range: nil)
      @point_repository = point_repository
      @user_account = user_account
      @date_range = date_range
    end

    def call
      @point_repository.get_user_points(
        @user_account.id, date_range: @date_range
      )
    end
  end
end
