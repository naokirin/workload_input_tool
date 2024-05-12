# frozen_string_literal: true

module User
  class UpdateTeamUsecase
    include UsecaseCallable

    def initialize(id:, name:, user_account_ids:)
      @id = id
      @name = name
      @user_account_ids = user_account_ids
    end

    def call
      team_members = build_team_members(user_team_id: @id, user_account_ids: @user_account_ids)
      User::TeamRepository.update(id: @id, name: @name, members: team_members || [])
    end

    private

    def build_team_members(user_team_id:, user_account_ids:)
      user_account_ids.map do |user_account_id|
        User::TeamMember.new(user_team_id:, user_account_id:)
      end
    end
  end
end
