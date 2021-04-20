class AddUsernameToProfileidTable < ActiveRecord::Migration[5.2]
  def change
    add_column :profile_ids, :user_name, :string
  end
end
