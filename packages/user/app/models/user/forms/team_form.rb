# frozen_string_literal: true

module User
  module Forms
    class TeamForm < ::Forms::Base
      attribute :name, :string
      attribute :user_accounts

      validates :name, presence: true
      validate :user_accounts_is_integer_array

      def user_accounts_is_integer_array
        return if user_accounts.nil?
        return if user_accounts.is_a?(Array) && user_accounts.all? { |id| id.is_a?(Integer) }
        errors.add(:user_accounts, 'はIDをしていしてください。')
      end
    end
  end
end
