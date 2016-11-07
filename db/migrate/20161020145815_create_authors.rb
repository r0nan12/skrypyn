class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :surname
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
