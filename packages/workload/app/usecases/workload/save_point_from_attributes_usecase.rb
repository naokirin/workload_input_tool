# frozen_string_literal: true

module Workload
  class SavePointFromAttributesUsecase
    include UsecaseCallable

    def initialize(point_repository:, group_repository:, attributes_list:, user_account:, date_range:)
      @point_repository = point_repository
      @group_repository = group_repository
      @attributes_list = attributes_list
      @user_account = user_account
      @date_range = date_range
    end

    def call
      points = AssignOrBuildUserPointsUsecase.call(
        point_repository: @point_repository, group_repository: @group_repository,
        user_account: @user_account,
        date_range: @date_range,
        attributes_list: @attributes_list
      )

      Workload::SaveUserPointsUsecase.call(point_repository: @point_repository, points:)
    end
  end
end
