# frozen_string_literal: true

module User
  class TeamRecord < ApplicationRecord
    self.table_name = 'user_teams'

    has_many :team_members, class_name: 'User::TeamMemberRecord', dependent: :destroy, foreign_key: 'user_team_id'
    has_many :user_accounts, through: :team_members, class_name: 'User::AccountRecord', foreign_key: 'user_account_id'
  end
end
