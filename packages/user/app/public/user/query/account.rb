# frozen_string_literal: true

module User
  module Query
    class Account
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :integer
      attribute :name, :string
      attribute :email, :string

      def self.from_record(record)
        self.new(
          id: record.id,
          name: record.name,
          email: record.email
        )
      end
    end
  end
end