# frozen_string_literal: true

module User
  module Query
    class Account
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :integer
      attribute :name, :string
      attribute :email, :string
      attribute :teams

      def self.from_record(record)
        new(
          id: record.id,
          name: record.name,
          email: record.email,
          teams: record.user_teams.map { |team| User::Query::Team.from_record(team) }
        )
      end
    end
  end
end
