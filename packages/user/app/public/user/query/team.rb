# frozen_string_literal: true

module User
  module Query
    class Team
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :integer
      attribute :name, :string

      def self.from_record(record)
        new(
          id: record.id,
          name: record.name
        )
      end
    end
  end
end
