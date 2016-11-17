class AddCreateDateToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :create_date, :date
  end
end
