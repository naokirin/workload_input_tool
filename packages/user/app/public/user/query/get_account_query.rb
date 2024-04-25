# frozen_string_literal: true

module User
  module Query
    module GetAccountQuery
      def call(id)
        user_account = User::AccountRecord.find(id)

        return nil if user_account.nil?

        User::Query::Account.new(
          id: id,
          name: user_account.name,
          email: user_account.email
        )
      end

      module_function :call
    end
  end
end
