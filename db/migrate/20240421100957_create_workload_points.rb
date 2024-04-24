class CreateWorkloadPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :workload_points do |t|
      t.bigint :workload_group_id, null: false
      t.bigint :user_account_id, null: false
      t.integer :value, null: true
      t.date :date, null: false


      t.timestamps
    end
  end
end
