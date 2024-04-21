class User::Account < ApplicationRecord
  devise :authenticatable, :database_authenticatable,
         :validatable, :registerable, :recoverable, :confirmable

  has_many :workload_points
end
