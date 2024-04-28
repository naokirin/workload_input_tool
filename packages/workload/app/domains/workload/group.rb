# frozen_string_literal: true

module Workload
  class Group
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :title, :string
    attribute :description, :string

    def self.from_record(record)
      new(
        id: record.id,
        title: record.title,
        description: record.description
      )
    end

    def ==(other)
      other.is_a?(self.class) &&
        id == other.id &&
        title == other.title &&
        description == other.description
    end

    def hash
      [self.class, id, title, description].hash
    end

    alias eql? ==
  end
end
