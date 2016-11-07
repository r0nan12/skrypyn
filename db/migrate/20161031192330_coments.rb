class Coments < ActiveRecord::Migration[5.0]
  def change
    create_table :coments do |t|
      t.text :text
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
      t.timestamps
    end
  end
end
