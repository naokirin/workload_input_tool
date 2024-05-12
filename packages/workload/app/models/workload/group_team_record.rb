# frozen_string_literal: true

module Workload
  class GroupTeamRecord < ApplicationRecord
    self.table_name = 'workload_group_teams'

    belongs_to :workload_group, class_name: 'Workload::GroupRecord'

    def user_team
      User::Query::Team.find(user_team_id)
    end
  end
end
