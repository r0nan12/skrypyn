class RemoveAuthorIdFromComents < ActiveRecord::Migration[5.0]
  def change
    remove_column :coments, :author_id
  end
end
