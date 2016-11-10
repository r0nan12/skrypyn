class RemoveUserIdFromRoles < ActiveRecord::Migration[5.0]
  def change
    remove_column :roles, :user_id
  end
end
