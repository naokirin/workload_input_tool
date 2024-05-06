class CreateUserTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :user_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
