class Interventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.string :author_ID
      t.integer :customer_id 
      t.integer :building_id
      t.integer :battery_id
      t.integer :column_id
      t.integer :elevator_id
      t.integer :employee_id
      t.datetime :start_of_intervention
      t.datetime :end_of_intervention
      t.string :result
      t.string :report
      t.string :status
    end
  end
end
