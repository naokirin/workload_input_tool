class CreateWorkloadPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :workload_points do |t|
      t.references :workload_group, null: false, foreign_key: true
      t.references :user_account, null: false, foreign_key: true
      t.integer :value, null: true
      t.date :date, null: false


      t.timestamps
    end
  end
end
