# frozen_string_literal: true

module User
  class Account
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :name, :string
    attribute :email, :string

    def self.from_record(record)
      new(
        id: record.id,
        name: record.name,
        email: record.email
      )
    end

    def ==(other)
      other.is_a?(self.class) &&
        id == other.id &&
        name == other.name &&
        email == other.email
    end

    def hash
      [self.class, id, name, email].hash
    end

    alias eql? ==
  end
end
