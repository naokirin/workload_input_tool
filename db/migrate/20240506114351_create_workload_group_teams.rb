class CreateWorkloadGroupTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :workload_group_teams do |t|
      t.references :workload_group, null: false
      t.bigint :user_team_id, null: false

      t.timestamps
    end
  end
end
