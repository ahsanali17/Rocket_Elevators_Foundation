class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :full_name_of_contact 
      t.string :company_name
      t.string :email
      t.string :phone
      t.string :project_name
      t.text   :project_description
      t.string :department_in_charge_of_elevators
      t.text   :message
      #Attached file stored as a binary file
      t.date   :date_of_contact_request

      t.timestamps
    end
  end
end






  