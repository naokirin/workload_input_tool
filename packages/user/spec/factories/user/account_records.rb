# frozen_string_literal: true

FactoryBot.define do
  factory :user_account_record, class: User::AccountRecord do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 128)  }
    password_confirmation { password }
  end
end
