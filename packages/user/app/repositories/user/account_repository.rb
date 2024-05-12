# frozen_string_literal: true

module User
  module AccountRepository
    def all
      User::AccountRecord.all.map { |record| User::Account.from_record(record) }
    end

    module_function :all
  end
end
