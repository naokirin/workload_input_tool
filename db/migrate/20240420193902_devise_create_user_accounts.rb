# frozen_string_literal: true

class DeviseCreateUserAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_accounts do |t|
      t.string :name, null: false, default: ""
      t.string :email

      # Confirmable
      t.string   :confirmation_token, null: false
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Database authenticatable
      t.string :encrypted_password, null: false

      t.timestamps null: false
    end

    add_index :user_accounts, :confirmation_token, unique: true
    add_index :user_accounts, :unconfirmed_email,  unique: true
    add_index :user_accounts, :email, unique: true
  end
end
