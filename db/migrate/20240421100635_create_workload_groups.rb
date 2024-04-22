class CreateWorkloadGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :workload_groups do |t|
      t.string :title, null: false
      t.string :description

      t.timestamps
    end
  end
end
