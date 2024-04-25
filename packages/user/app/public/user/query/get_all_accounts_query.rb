# frozen_string_literal: true

module User
  module Query
    module GetAllAccountsQuery
      def call
        User::AccountRecord.all.map do |user_account|
          User::Query::Account.from_record(user_account)
        end
      end

      module_function :call
    end
  end
end
