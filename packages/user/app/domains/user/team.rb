# frozen_string_literal: true

module User
  class Team
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :name, :string
    attribute :members

    def self.from_record(record)
      new(
        id: record.id,
        name: record.name,
        members: record.user_accounts.lazy.map { |member| User::Account.from_record(member) }
      )
    end

    def ==(other)
      other.is_a?(self.class) &&
        id == other.id &&
        name == other.name
    end

    def hash
      [self.class, id, name].hash
    end

    alias eql? ==
  end
end
