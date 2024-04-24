# frozen_string_literal: true

module User
  module Query
    class Account
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :id, :integer
      attribute :name, :string
      attribute :email, :string
    end
  end
end