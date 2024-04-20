class User::Account < ApplicationRecord
  devise :authenticatable, :database_authenticatable,
         :validatable, :registerable, :recoverable, :confirmable
end
