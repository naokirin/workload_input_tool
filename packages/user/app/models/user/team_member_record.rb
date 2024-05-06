# frozen_string_literal: true

module User
  class TeamMemberRecord < ApplicationRecord
    self.table_name = 'user_team_members'

    belongs_to :user_team, class_name: 'User::TeamRecord'
    belongs_to :user_account, class_name: 'User::AccountRecord'
  end
end
