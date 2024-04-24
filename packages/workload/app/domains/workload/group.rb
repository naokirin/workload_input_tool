# frozen_string_literal: true

module Workload
  class Group
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :id, :integer
    attribute :title, :string
    attribute :description, :string

    def self.from_record(record)
      self.new(
        id: record.id,
        title: record.title,
        description: record.description
      )
    end
  end
end
