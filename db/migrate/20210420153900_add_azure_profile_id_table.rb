class AddAzureProfileIdTable < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_ids do |t|
      t.string :profile_id
    end
  end
end
