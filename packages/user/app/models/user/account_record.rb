# frozen_string_literal: true

class User::AccountRecord < ApplicationRecord
  self.table_name = "user_accounts"

  devise :authenticatable, :database_authenticatable,
         :validatable, :registerable, :recoverable, :confirmable,
         password_length: 10..128

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, length: { maximum: 100 }
  validates :password, password_strength: true
end
