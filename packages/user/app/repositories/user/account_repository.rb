# frozen_string_literal: true

module User
  module AccountRepository
    extend self

    def all
      User::AccountRecord.all.map { |record| User::Account.from_record(record) }
    end
  end
end
