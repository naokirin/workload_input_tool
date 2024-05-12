# frozen_string_literal: true

module User
  class TeamMember
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :user_team_id, :integer
    attribute :user_account_id, :integer

    def self.from_record(record)
      new(
        id: record.id,
        user_team_id: record.user_team_id,
        user_account_id: record.user_account_id
      )
    end

    def ==(other)
      other.is_a?(self.class) &&
        id == other.id &&
        user_team_id == other.user_team_id &&
        user_account_id == other.user_account_id
    end

    def hash
      [self.class, id, user_team_id, user_account_id].hash
    end

    alias eql? ==
  end
end
