# frozen_string_literal: true

module User
  class ApplicationController < ::ApplicationController
    private

    def current_user_account
      user_account = super
      return nil if user_account.nil?

      User::Query::Account.from_record(user_account)
    end
  end
end
