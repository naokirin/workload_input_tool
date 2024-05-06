# frozen_string_literal: true

module User
  class AccountRecord < ApplicationRecord
    self.table_name = 'user_accounts'

    devise :authenticatable, :database_authenticatable,
           :validatable, :registerable, :recoverable, :confirmable,
           password_length: 10..128

    has_many :team_members, class_name: 'User::TeamMemberRecord', dependent: :destroy
    has_many :user_teams, through: :team_members, class_name: 'User::TeamRecord'

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, length: { maximum: 100 }
    validates :password, password_strength: true
  end
end
