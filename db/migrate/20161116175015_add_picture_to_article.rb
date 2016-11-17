class AddPictureToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :avatar, :has_attached_file
  end
end
