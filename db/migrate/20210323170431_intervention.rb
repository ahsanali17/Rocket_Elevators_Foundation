class Intervention < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
     t.string :author, foreign_key: {to_table: :employees} 
     t.references :customer, null: false, foreign_key: true 
     t.references :building, null: false, foreign_key: true 
     t.references :battery, null: true, foreign_key: true 
     t.references :column, null: true, foreign_key: true 
     t.references :elevator, null: true, foreign_key: true 
     t.references :employee, null: true, foreign_key: true 
     t.datetime :start_of_intervention
     t.datetime :end_of_intervention
     t.string :result
     t.string :report
     t.string :status
    end
  end
end