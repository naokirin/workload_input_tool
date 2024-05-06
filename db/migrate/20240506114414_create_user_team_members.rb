class CreateUserTeamMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :user_team_members do |t|
      t.references :user_account, null: false
      t.references :user_team, null: false

      t.timestamps
    end
  end
end
