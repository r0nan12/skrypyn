class AddTotalComentsToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :total_coments, :integer
  end
end
