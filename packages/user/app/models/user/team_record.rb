# frozen_string_literal: true

module User
  class TeamRecord < ApplicationRecord
    self.table_name = 'user_teams'

    has_many :team_members, class_name: 'User::TeamMemberRecord'
    has_many :user_accounts, through: :team_members, class_name: 'User::AccountRecord'
  end
end
